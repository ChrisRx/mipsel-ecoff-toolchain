# mipsel-ecoff-toolchain
A cross compiler toolchain for the Sony Playstation [Net Yaroze](https://en.wikipedia.org/wiki/Net_Yaroze). The Net Yaroze SDK (included) uses the mipsel-ecoff target which has long since been considered obselete in GCC and therefore requires a much older version of GCC. Compiling these older versions of Binutils/GCC is achieved by using a modern version of GCC to compile an intermediate version of GCC that allows stepping backwards to the desired version (e.g. GCC v8.2.1 -> GCC v3.3.4 -> GCC v2.95.2). The final cross compiler is then able to cross compile the defunct combination of 32-bit MIPS (LE) and the ECOFF file object format used with the Net Yaroze SDK.

# Building

If a `PREFIX` isn't given, it simply defaults to `$PWD/yaroze`.

```
./mipsel-ecoff-toolchain PREFIX=$PWD/yaroze
```

This will make folders during the build process: `{build,sources,stamps}`. These can be cleaned up also using `make clean`.

# Compiling the sample

The sample project is one included with the Net Yaroze SDK and can be used to verify that the toolchain is working:

```
cd <PREFIX>/mipsel-ecoff/sample
make
```

Should produce a binary that looks like this:

```
$ file main
main: MIPSEL ECOFF executable (paged) not stripped - version 2.11
```

# Resources

 * [PSXDEV](http://www.psxdev.net/) - the community here is great and has collected a lot of helpful info about PSX development
 * [Net Yaroze For Linux](http://www.cebix.net/downloads/yarlinux.pdf)
