# Copyright 2005 The Android Open Source Project
#
# Android.mk for adb
#

adb_version := $(shell git submodule status core | cut -c2-9)-android

ADB_COMMON_CXXFLAGS := \
    -DADB_HOST=1 \
    -DADB_REVISION='"$(adb_version)"' \
    -I$(srcdir)/boringssl/include \
    -I$(srcdir)/core/base/include \
    -I$(srcdir)/core/include \
    -I$(srcdir)/core/libcrypto_utils/include \
    -I$(srcdir)/include \
    -Wexit-time-destructors \
    -Wno-missing-field-initializers \
    -Wvla \

# libadb
# =========================================================

LIBADB_ARCHIVE := obj/libadb/libadb.a

LIBADB_CXXFLAGS := \
    $(ADB_COMMON_CXXFLAGS) \
    -fvisibility=hidden \
    -I$(srcdir)/core/adb \
    -I$(srcdir)/libusb/include \
    -I$(srcdir)/mdnsresponder/mDNSShared \

LIBADB_SRC_FILES := \
    adb.cpp \
    adb_auth_host.cpp \
    adb_io.cpp \
    adb_listeners.cpp \
    adb_trace.cpp \
    adb_utils.cpp \
    client/usb_dispatch.cpp \
    client/usb_libusb.cpp \
    client/usb_linux.cpp \
    fdevent.cpp \
    sockets.cpp \
    socket_spec.cpp \
    sysdeps/errno.cpp \
    sysdeps/posix/network.cpp \
    sysdeps_unix.cpp \
    transport.cpp \
    transport_local.cpp \
    transport_mdns.cpp \
    transport_usb.cpp \

LIBADB_OBJ_FILES := \
    $(patsubst %.cpp,obj/libadb/%.o,$(LIBADB_SRC_FILES))

DIRS += $(dir $(LIBADB_OBJ_FILES))

libadb: $(LIBADB_ARCHIVE)

$(LIBADB_ARCHIVE): $(LIBADB_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBADB_OBJ_FILES): obj/libadb/%.o: $(srcdir)/core/adb/%.cpp | dirs
	$(CXX) $(CXXFLAGS) $(LIBADB_CXXFLAGS) -c -o $@ $^

# libdiagnose_usb
# =========================================================

LIBDIAGNOSE_USB_ARCHIVE := obj/libdiagnose_usb/libdiagnose_usb.a

LIBDIAGNOSE_USB_CXXFLAGS := \
    $(ADB_COMMON_CXXFLAGS) \
    -fvisibility=hidden \

LIBDIAGNOSE_USB_SRC_FILES := \
    diagnose_usb.cpp \

LIBDIAGNOSE_USB_OBJ_FILES := \
    $(patsubst %.cpp,obj/libdiagnose_usb/%.o,$(LIBDIAGNOSE_USB_SRC_FILES))

DIRS += $(dir $(LIBDIAGNOSE_USB_OBJ_FILES))

libdiagnose_usb: $(LIBDIAGNOSE_USB_ARCHIVE)

$(LIBDIAGNOSE_USB_ARCHIVE): $(LIBDIAGNOSE_USB_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBDIAGNOSE_USB_OBJ_FILES): obj/libdiagnose_usb/%.o: $(srcdir)/core/adb/%.cpp | dirs
	$(CXX) $(CXXFLAGS) $(LIBDIAGNOSE_USB_CXXFLAGS) -c -o $@ $^

# adb host tool
# =========================================================

ADB_BINARY := obj/adb/adb

ADB_CXXFLAGS := \
    $(ADB_COMMON_CXXFLAGS) \
    -D_GNU_SOURCE \
    -I$(srcdir)/core/adb \

ADB_LIBS := \
    libadb \
    libbase \
    libcrypto \
    libcrypto_utils \
    libcutils \
    libdiagnose_usb \
    libmdnssd \
    libusb \

ADB_SRC_FILES := \
    adb_client.cpp \
    bugreport.cpp \
    client/main.cpp \
    console.cpp \
    commandline.cpp \
    file_sync_client.cpp \
    line_printer.cpp \
    services.cpp \
    shell_service_protocol.cpp \

ADB_LIB_DEPS := \
	$(foreach lib,$(ADB_LIBS),obj/$(lib)/$(lib).a)

ADB_OBJ_FILES := \
    $(patsubst %.cpp,obj/adb/%.o,$(ADB_SRC_FILES))

BINS += $(ADB_BINARY)
DIRS += $(dir $(ADB_OBJ_FILES))

adb: $(ADB_BINARY)

$(ADB_BINARY): $(ADB_OBJ_FILES) $(ADB_LIB_DEPS) | dirs
	$(CXX) $(CXXFLAGS) $(ADB_CXXFLAGS) -o $@ $^ $(LDFLAGS) $(ADB_LDFLAGS)

$(ADB_OBJ_FILES): obj/adb/%.o: $(srcdir)/core/adb/%.cpp | dirs
	$(CXX) $(CXXFLAGS) $(ADB_CXXFLAGS) -c -o $@ $^
