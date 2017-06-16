srcdir := $(PWD)

CC = clang
CFLAGS ?= -g0 -Os
CFLAGS += \
    -std=gnu11 \
    -Wall \
    -Werror\
    -Wextra \
    -Wno-unused-function \
    -Wno-unused-parameter \
    -Wno-unused-variable \
    -Wno-\#warnings
CXX = clang++
CXXFLAGS ?= -g0 -Os
CXXFLAGS += \
    -std=gnu++14 \
    -Wall \
    -Werror \
    -Wextra \
    -Wno-unused-function \
    -Wno-unused-parameter \
    -Wno-unused-private-field \
    -Wno-unused-variable \
    -Wno-\#warnings
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

include rules/adb.mk
include rules/boringssl.mk
include rules/fastboot.mk
include rules/libbase.mk
include rules/libcrypto_utils.mk
include rules/libcutils.mk
include rules/libext4_utils.mk
include rules/liblog.mk
include rules/libmdnssd.mk
include rules/libpcre.mk
include rules/libselinux.mk
include rules/libsparse.mk
include rules/libusb.mk
include rules/libutils.mk
include rules/libziparchive.mk

BINS += core/mkbootimg/mkbootimg

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
