srcdir := $(PWD)

CC := clang
CFLAGS := -Os -pipe
CXX := clang++
CXXFLAGS := -Os -pipe
LDFLAGS := -static

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
include rules/libpcre.mk
include rules/libselinux.mk
include rules/libsparse.mk
include rules/libusb.mk
include rules/libutils.mk
include rules/libziparchive.mk

BINS := $(sort $(BINS))
DIRS := $(sort $(DIRS))

all: $(BINS)
dirs: $(DIRS)

$(DIRS):
	mkdir -p $@

.PHONY: all clean dirs
