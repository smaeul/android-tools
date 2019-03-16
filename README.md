# adb, fastboot, img2simg, and simg2img for musl

This is an effort to extract Android's low-level system imaging tools from its massive build system,
as well as make sure they compile properly against the musl libc. The major feature here is
accomplishing that goal while patching or modifying the upstream sources from AOSP as little as
possible.  This makes updating much easier -- simply examining the changes to relevant `Android.bp`
and `Android.mk` files, without worrying about source changes. I use these tools frequently, so this
will get updated at least every couple of months.

## Prerequisites

As Google uses clang++ to build the Android userspace, this project requires a relatively recent
version of clang++ and libc++ to compile. It will not work with g++; if you try it, you're on your
own.

## How to Use

Simply run `make` to compile the utilities along with several necessary libraries. The binaries are
statically linked to all android libraries, but they depend on `libcrypto` and `libz` from the host.
The build system uses `pkg-config` to find the right `CFLAGS` and `LDFLAGS` for those libraries. Run
`make install` to install the final binaries to /usr/bin, or specify `PREFIX` or `DESTDIR` to
override the install destination.

## What about glibc?

As of March 2019, the utilities should build with glibc. However, I don't use glibc, so I cannot
guarantee that it will continue to work. I'll apply changes that fix glibc without breaking
the build with musl. Open an issue if the build fails on glibc.
