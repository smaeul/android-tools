# adb, fastboot, img2simg, and simg2img for musl

This is an effort to extract Android's low-level system imaging tools from its massive build system,
as well as make sure they compile properly against the musl libc. The major feature here is
accomplishing that goal without patching or modifying the upstream sources from AOSP in any way.
This makes updating much easier -- simply examining the changes to relevant `Android.bp` and
`Android.mk` files, without worrying about source changes. I use these tools frequently, so this
will get updated at least every couple of months.

## Prerequisites

As Google uses clang to build the Android userspace, this project requires a relatively recent
version of clang to compile. It may or may not work with g++; if you try it, you're on your own.

## How to Use

Simply run `make` to compile the utilities along with several necessary libraries. The binaries are
statically linked (including to libc), so they will be portable to any Linux distribution. Run `make
install` to install them to /usr/bin, or specify `PREFIX` or `DESTDIR` to override the install
destination.

## What about glibc?

I'm not opposed to changes that fix glibc without breaking the build with musl, or I'd accept
contributions to a separate glibc branch. I don't use glibc, so I don't plan to do it myself.
