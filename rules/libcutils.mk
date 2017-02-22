# libcutils
# =========================================================

LIBCUTILS_ARCHIVE := obj/libcutils/libcutils.a

LIBCUTILS_CFLAGS := \
    -include uchar.h \
    -I$(srcdir)/core/include \
    -I$(srcdir)/include \
    -std=gnu11 \
    -Wall -Wextra -Werror \

LIBCUTILS_CXXFLAGS := \
    -I$(srcdir)/core/include \
    -I$(srcdir)/include \
    -std=gnu++14 \
    -Wall -Wextra -Werror \
    -Wexit-time-destructors \

LIBCUTILS_SRC_FILES := \
    android_get_control_file.cpp \
    ashmem-host.c \
    config_utils.c \
    fs.c \
    fs_config.c \
    canned_fs_config.c \
    dlmalloc_stubs.c \
    hashmap.c \
    iosched_policy.c \
    load_file.c \
    multiuser.c \
    native_handle.c \
    open_memstream.c \
    record_stream.c \
    sched_policy.cpp \
    sockets.cpp \
    socket_inaddr_any_server_unix.c \
    socket_local_client_unix.c \
    socket_local_server_unix.c \
    socket_loopback_server_unix.c \
    socket_network_client_unix.c \
    sockets_unix.cpp \
    str_parms.c \
    strdup16to8.c \
    strdup8to16.c \
    strlcpy.c \
    threads.c \
    trace-host.c \

LIBCUTILS_C_OBJ_FILES := \
    $(patsubst %.c,obj/libcutils/%.o,$(filter %.c,$(LIBCUTILS_SRC_FILES)))

LIBCUTILS_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libcutils/%.o,$(filter %.cpp,$(LIBCUTILS_SRC_FILES)))

DIRS += $(dir $(LIBCUTILS_C_OBJ_FILES) $(LIBCUTILS_CXX_OBJ_FILES))

libcutils: $(LIBCUTILS_ARCHIVE)

$(LIBCUTILS_ARCHIVE): $(LIBCUTILS_C_OBJ_FILES) $(LIBCUTILS_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBCUTILS_C_OBJ_FILES): obj/libcutils/%.o: $(srcdir)/core/libcutils/%.c | dirs
	$(CC) $(LIBCUTILS_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBCUTILS_CXX_OBJ_FILES): obj/libcutils/%.o: $(srcdir)/core/libcutils/%.cpp | dirs
	$(CXX) $(LIBCUTILS_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
