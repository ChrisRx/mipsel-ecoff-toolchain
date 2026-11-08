#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>
#include "wasi-compat.h"

/* A WASI program starts in "/", whatever directory the host ran it in, so
   one given PWD, as mipsel-ecoff-gcc gives each, starts there instead, and
   finds a relative path where the host does. Every program links the whole
   of this library, since only a member that is linked whole has its
   constructor run.  */
__attribute__((constructor)) void
wasi_compat_cwd(void)
{
	const char *pwd = getenv("PWD");

	if (pwd != NULL && pwd[0] == '/')
		chdir(pwd);
}

#define NOSYS(decl) decl { errno = ENOSYS; return -1; }
NOSYS(int fork(void))
NOSYS(int vfork(void))
NOSYS(int execv(const char *p, char *const a[]))
NOSYS(int execvp(const char *p, char *const a[]))
NOSYS(int wait(int *s))
NOSYS(int waitpid(int p, int *s, int o))
NOSYS(int pipe(int f[2]))
NOSYS(int dup2(int f, int g))
NOSYS(int dup(int f))
NOSYS(int system(const char *c))
NOSYS(int kill(int p, int s))

/* There are no permission bits to mask: WASI's files have none. */
unsigned int umask(unsigned int m) { return 022; }

/* Nor owners: a file is everyone's. */
int chown(const char *p, unsigned int u, unsigned int g) { return 0; }

/* WASI's files have no permission bits, so stat reports none, which ar
   would record for each member of an archive and tar or ar would give the
   file it extracts: they report what a file is usually given instead. The
   programs link these in place of stat, fstat and lstat, by --wrap.  */
static void
permissions(struct stat *st)
{
	if ((st->st_mode & 07777) == 0)
		st->st_mode |= S_ISDIR(st->st_mode) ? 0755 : 0644;
}

int __real_stat(const char *, struct stat *);
int __real_fstat(int, struct stat *);
int __real_lstat(const char *, struct stat *);

int
__wrap_stat(const char *path, struct stat *st)
{
	int r = __real_stat(path, st);

	if (r == 0)
		permissions(st);
	return r;
}

int
__wrap_fstat(int fd, struct stat *st)
{
	int r = __real_fstat(fd, st);

	if (r == 0)
		permissions(st);
	return r;
}

int
__wrap_lstat(const char *path, struct stat *st)
{
	int r = __real_lstat(path, st);

	if (r == 0)
		permissions(st);
	return r;
}

/* mktemp fills the trailing XXXXXX with a name no file has yet. */
char *
mktemp(char *t)
{
	static unsigned n;
	size_t len = strlen(t);
	struct stat st;

	if (len < 6 || strcmp(t + len - 6, "XXXXXX") != 0) {
		errno = EINVAL;
		t[0] = 0;
		return t;
	}
	for (int i = 0; i < 100000; i++) {
		snprintf(t + len - 6, 7, "%06u", (n++ * 2654435761u) % 1000000);
		if (stat(t, &st) != 0)
			return t;
	}
	t[0] = 0;
	return t;
}
