srcdir := $(PWD)

CC = clang
CFLAGS ?= -g0 -Os
CFLAGS += \
    -std=gnu11 \
    -Wall \
    -Wextra \
    -Werror=implicit-function-declaration \
    -Werror=implicit-int \
    -Wno-unused-parameter
CXX = clang++ -stdlib=libc++
CXXFLAGS ?= -g0 -Os
CXXFLAGS += \
    -std=gnu++2a \
    -Wall \
    -Wextra \
    -Werror=implicit-function-declaration \
    -Werror=implicit-int \
    -Wno-unused-parameter
LDFLAGS ?= -s -static -Wl,--hash-style=both
LDFLAGS += \
    -Wl,--no-undefined \
    -Wl,-z,noexecstack \
    -Wl,-z,now \
    -Wl,-z,relro
PREFIX = /usr

all:

clean:
	rm -fr obj

obj/%: %.py | dirs
	{ cp $< $@ && chmod +x $@; } || rm -f $@

include rules/adb.mk
include rules/boringssl.mk
include rules/fastboot.mk
include rules/libbase.mk
include rules/libcrypto_utils.mk
include rules/libcutils.mk
include rules/libdiagnose_usb.mk
include rules/libext4_utils.mk
include rules/liblog.mk
include rules/liblp.mk
include rules/libmdnssd.mk
include rules/libpcre.mk
include rules/libselinux.mk
include rules/libsparse.mk
include rules/libusb.mk
include rules/libutils.mk
include rules/libziparchive.mk

BINS += obj/core/mkbootimg/mkbootimg
BINS += obj/core/mkbootimg/unpack_bootimg
DIRS += obj/core/mkbootimg

BINS := $(sort $(BINS))
DIRS := $(sort $(DIRS))

all: $(BINS)
dirs: $(DIRS)

$(DIRS):
	mkdir -p $@

install: $(BINS)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m0755 $(BINS) $(DESTDIR)$(PREFIX)/bin

.PHONY: all clean dirs install
