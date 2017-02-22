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
include rules/base.mk
include rules/boringssl.mk
include rules/crypto_utils.mk
include rules/cutils.mk

BINS := $(sort $(BINS))
DIRS := $(sort $(DIRS))

all: $(BINS)
dirs: $(DIRS)

$(DIRS):
	mkdir -p $@

.PHONY: all clean dirs
