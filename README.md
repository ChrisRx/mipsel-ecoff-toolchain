# mipsel-ecoff-toolchain
A cross compiler toolchain for the Sony Playstation [Net Yaroze](https://en.wikipedia.org/wiki/Net_Yaroze). The Net Yaroze SDK (included) uses the mipsel-ecoff target which has long since been considered obselete in GCC and therefore requires a much older version of GCC. Compiling these older versions of Binutils/GCC is achieved by using a modern version of GCC to compile an intermediate version of GCC that allows stepping backwards to the desired version (e.g. GCC v8.2.1 -> GCC v3.3.4 -> GCC v2.95.2). The final cross compiler is then able to cross compile the defunct combination of 32-bit MIPS (LE) and the ECOFF file object format used with the Net Yaroze SDK.

# Building

If a `PREFIX` isn't given, it simply defaults to `$PWD/yaroze`.

```
./mipsel-ecoff-toolchain PREFIX=$PWD/yaroze
```

This will make folders during the build process: `{build,sources,stamps}`. These can be cleaned up also using `make clean`.

Originally, I was building this toolchain in a docker container, but ultimately found it not necessary on the OSes I was working with (Ubuntu and Arch Linux). However, others have had success building this toolchain on a different OS/platform using docker. For example, [docker-yaroze](https://github.com/Davermouse/docker-yaroze) has compiled Net Yaroze executables successfully on macOS. I'm unfamiliar with the docker environment on Windows, but the capability to run linux containers should be roughly the same (probably through WSL). In any case, it's worth giving a look if you are needing to build on a non-linux OS.

# Compiling the sample

The sample project is one included with the Net Yaroze SDK and can be used to verify that the toolchain is working:

```
cd <PREFIX>/mipsel-ecoff/sample/sjiscode
make
```

Should produce a binary that looks like this:

```
$ file main
main: MIPSEL ECOFF executable (paged) not stripped - version 2.11
```

# Running executables

Since Net Yaroze executables are not PSX-EXE files (PS1 executable format) they cannot be loaded into an emulator or CD iso builder. The Net Yaroze Boot Disk (DTL-S3035) runs a program that listens for serial I/O commands and loads the entire Net Yaroze SDK into memory. At this point, SIOCONS.EXE can be used to load the Net Yaroze executable at the correct starting address and the serial command to execute whats loaded into memory can then be sent. It is possible to prebuild a PSX-EXE that loads a bare Net Yaroze executable in a similar way by combining it with the SDK into a single PSX-EXE file. To do this, I've adapted the [https://github.com/gwald/Yarexe](https://github.com/gwald/Yarexe) tool (itself also a combination of the work of others) into [eco2exe](https://github.com/ChrisRx/psxsdk#eco2exe) over in the repo I currently keep assorted psx/ny dev tools. I adapted it with the hopes that it will be slightly more portable and maintainable as a Go project.

With a valid PSX-EXE it can now be ran in emulators that can load the PSX-EXE format (mednafen, NO$PSX) or a PSX CD image can be made with something like [https://github.com/Lameguy64/mkpsxiso](https://github.com/Lameguy64/mkpsxiso).

# Resources

 * [PSXDEV](http://www.psxdev.net/) - the community here is great and has collected a lot of helpful info about PSX development
 * [Net Yaroze For Linux](http://www.cebix.net/downloads/yarlinux.pdf)
