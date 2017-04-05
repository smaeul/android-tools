# libusb
# =========================================================

LIBUSB_ARCHIVE := obj/libusb/libusb.a

LIBUSB_CFLAGS := \
    -I$(srcdir)/libusb/include \
    -I$(srcdir)/libusb/libusb \
    -I$(srcdir)/libusb/libusb/os \
    -I$(srcdir)/libusb/linux \

LIBUSB_SRC_FILES := \
    core.c \
    descriptor.c \
    hotplug.c \
    io.c \
    sync.c \
    strerror.c \
    os/linux_usbfs.c \
    os/poll_posix.c \
    os/threads_posix.c \
    os/linux_netlink.c \

LIBUSB_C_OBJ_FILES := \
    $(patsubst %.c,obj/libusb/%.o,$(filter %.c,$(LIBUSB_SRC_FILES)))

LIBUSB_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libusb/%.o,$(filter %.cpp,$(LIBUSB_SRC_FILES)))

DIRS += $(dir $(LIBUSB_C_OBJ_FILES) $(LIBUSB_CXX_OBJ_FILES))

libusb: $(LIBUSB_ARCHIVE)

$(LIBUSB_ARCHIVE): $(LIBUSB_C_OBJ_FILES) $(LIBUSB_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBUSB_C_OBJ_FILES): obj/libusb/%.o: $(srcdir)/libusb/libusb/%.c | dirs
	$(CC) $(LIBUSB_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBUSB_CXX_OBJ_FILES): obj/libusb/%.o: $(srcdir)/libusb/libusb/%.cpp | dirs
	$(CXX) $(LIBUSB_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
