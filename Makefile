srcdir := $(PWD)

CC := clang
CFLAGS := -Os -pipe
CXX := clang++
CXXFLAGS := -Os -pipe
LDFLAGS := -static

all: adb

clean:
	rm -fr obj

include rules/adb.mk
include rules/base.mk
include rules/crypto_utils.mk
include rules/cutils.mk

DIRS += obj/boringssl

obj/libcrypto/libcrypto.a: | dirs
	(cd obj/boringssl && cmake $(srcdir)/boringssl)
	$(MAKE) -C obj/boringssl crypto
	ln -s boringssl/crypto obj/libcrypto

DIRS := $(sort $(DIRS))

dirs: $(DIRS)

$(DIRS): %:
	mkdir -p $@

.PHONY: all clean dirs
