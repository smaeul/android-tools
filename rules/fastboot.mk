fastboot_version := $(shell git submodule status core | cut -c2-9)-android

FASTBOOT_COMMON_CXXFLAGS := \
    -DFASTBOOT_VERSION='"$(fastboot_version)"' \

# libfastboot
# =========================================================

LIBFASTBOOT_ARCHIVE := obj/libfastboot/libfastboot.a

LIBFASTBOOT_CXXFLAGS := \
    $(FASTBOOT_COMMON_CXXFLAGS) \
    -include sys/select.h \
    -I$(srcdir)/core/base/include \
    -I$(srcdir)/core/diagnose_usb/include \
    -I$(srcdir)/core/fs_mgr/liblp/include \
    -I$(srcdir)/core/libcutils/include \
    -I$(srcdir)/core/libsparse/include \
    -I$(srcdir)/core/libziparchive/include \
    -I$(srcdir)/core/mkbootimg/include/bootimg \
    -I$(srcdir)/include \

LIBFASTBOOT_SRC_FILES := \
    bootimg_utils.cpp \
    fastboot.cpp \
    fastboot_driver.cpp \
    fs.cpp \
    socket.cpp \
    tcp.cpp \
    udp.cpp \
    usb_linux.cpp \

LIBFASTBOOT_OBJ_FILES := \
    $(patsubst %.cpp,obj/libfastboot/%.o,$(LIBFASTBOOT_SRC_FILES))

DIRS += $(dir $(LIBFASTBOOT_OBJ_FILES))

libfastboot: $(LIBFASTBOOT_ARCHIVE)

$(LIBFASTBOOT_ARCHIVE): $(LIBFASTBOOT_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBFASTBOOT_OBJ_FILES): obj/libfastboot/%.o: $(srcdir)/core/fastboot/%.cpp | dirs
	$(CXX) $(CXXFLAGS) $(LIBFASTBOOT_CXXFLAGS) -c -o $@ $^

# fastboot host tool
# =========================================================

FASTBOOT_BINARY := obj/fastboot/fastboot

FASTBOOT_CXXFLAGS := \
    $(FASTBOOT_COMMON_CXXFLAGS) \
    -I$(srcdir)/core/fastboot \
    -I$(srcdir)/core/include \
    -I$(srcdir)/core/mkbootimg/include/bootimg \
    -I$(srcdir)/extras/ext4_utils/include \
    -I$(srcdir)/extras/f2fs_utils \

FASTBOOT_LDFLAGS := \
    -lz \

FASTBOOT_LIBS := \
    libfastboot \
    libbase \
    libcutils \
    libdiagnose_usb \
    libselinux \
    libsparse \
    libziparchive \
    liblog \
    liblp \
    libext4_utils \
    libpcre \
    libutils \

FASTBOOT_SRC_FILES := \
    main.cpp \
    util.cpp \

FASTBOOT_LIB_DEPS := \
    $(foreach lib,$(FASTBOOT_LIBS),obj/$(lib)/$(lib).a)

FASTBOOT_OBJ_FILES := \
    $(patsubst %.cpp,obj/fastboot/%.o,$(FASTBOOT_SRC_FILES))

BINS += $(FASTBOOT_BINARY)
DIRS += $(dir $(FASTBOOT_OBJ_FILES))

fastboot: $(FASTBOOT_BINARY)

$(FASTBOOT_BINARY): $(FASTBOOT_OBJ_FILES) $(FASTBOOT_LIB_DEPS) | dirs
	$(CXX) $(CXXFLAGS) $(FASTBOOT_CXXFLAGS) -o $@ $^ $(LDFLAGS) $(FASTBOOT_LDFLAGS)

$(FASTBOOT_OBJ_FILES): obj/fastboot/%.o: $(srcdir)/core/fastboot/%.cpp | dirs
	$(CXX) $(CXXFLAGS) $(FASTBOOT_CXXFLAGS) -c -o $@ $^
