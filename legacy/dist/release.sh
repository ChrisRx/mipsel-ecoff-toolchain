#!/usr/bin/env bash
# Publishes toolchain archives to the psxsdk bucket on Cloudflare R2, each at
# toolchains/NAME, with its SHA-256 in toolchains/NAME.sha256. An archive
# whose SHA-256 is published already is left as it is. There is one build of
# each: these toolchains are not meant to change, so a new build corrects the
# last one and replaces it.
#
# Uploading needs the R2_ACCOUNT_ID, R2_ACCESS_KEY_ID and R2_SECRET_ACCESS_KEY
# of a key that can write to the bucket, in the environment or in the file
# R2_ENV names, and aws, the AWS CLI. Finding that an archive is there needs
# neither.
#
# Usage: release.sh ARCHIVE...
set -euo pipefail
[ $# -gt 0 ] || { echo "usage: release.sh ARCHIVE..." >&2; exit 2; }
BUCKET=psxsdk
PUBLIC=https://files.yaroze.dev

upload() { # file, key, cache-control, content-type
  aws s3 cp "$1" "s3://$BUCKET/$2" \
    --endpoint-url "https://$R2_ACCOUNT_ID.r2.cloudflarestorage.com" \
    --cache-control "$3" --content-type "$4" --no-progress
}

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
credentials=
for archive in "$@"; do
  # Without the hash a store path starts with.
  name=$(basename "$archive" | sed -E 's/^[0-9a-z]{32}-//')
  sum=$(sha256sum "$archive" | cut -d' ' -f1)

  # Cloudflare keeps a 404 for hours, so asking for the file itself before
  # it is uploaded would have it missing for that long after. A query of
  # its own asks without touching what the file's URL has cached.
  published=$(curl -fsS "$PUBLIC/toolchains/$name.sha256?check=$(date +%s)" 2>/dev/null | cut -d' ' -f1 || true)
  if [ "$published" = "$sum" ]; then
    echo "release.sh: $name is there already"
    continue
  fi

  if [ -z "$credentials" ]; then
    if [ -n "${R2_ENV:-}" ]; then
      # shellcheck disable=SC1090
      source "$R2_ENV"
    fi
    : "${R2_ACCOUNT_ID:?release.sh: set R2_ACCOUNT_ID, R2_ACCESS_KEY_ID and R2_SECRET_ACCESS_KEY, or R2_ENV to a file that does}"
    export AWS_ACCESS_KEY_ID=$R2_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$R2_SECRET_ACCESS_KEY AWS_DEFAULT_REGION=auto
    # R2 does not take the checksums the command sends by default.
    export AWS_REQUEST_CHECKSUM_CALCULATION=when_required AWS_RESPONSE_CHECKSUM_VALIDATION=when_required
    credentials=1
  fi

  printf '%s  %s\n' "$sum" "$name" > "$WORK/$name.sha256"
  # Cached for an hour, so that a replacement shows within one, and the
  # .sha256 goes last, since that is what says the archive is there.
  upload "$archive" "toolchains/$name" 'public, max-age=3600' application/gzip
  upload "$WORK/$name.sha256" "toolchains/$name.sha256" 'public, max-age=3600' text/plain
  echo "release.sh: published $name at $PUBLIC/toolchains/$name"
done
