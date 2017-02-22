# libselinux
# =========================================================

LIBSELINUX_ARCHIVE := obj/libselinux/libselinux.a

LIBSELINUX_CFLAGS := \
    -D_GNU_SOURCE \
    -DAUDITD_LOG_TAG=1003 \
    -DBUILD_HOST \
    -DDISABLE_BOOL \
    -DDISABLE_SETRANS \
    -DNO_DB_BACKEND \
    -DNO_MEDIA_BACKEND \
    -DNO_PERSISTENTLY_STORED_PATTERNS \
    -DNO_X_BACKEND \
    -DUSE_PCRE2 \
    -I$(srcdir)/pcre/include \
    -I$(srcdir)/selinux/libselinux/include \
    -I$(srcdir)/selinux/libsepol/include \
    -std=gnu11 \
    -Wno-pointer-bool-conversion

LIBSELINUX_SRC_FILES := \
    src/android/android_host.c \
    src/avc.c \
    src/avc_internal.c \
    src/avc_sidtab.c \
    src/booleans.c \
    src/callbacks.c \
    src/compute_av.c \
    src/compute_create.c \
    src/compute_member.c \
    src/context.c \
    src/enabled.c \
    src/freecon.c \
    src/get_initial_context.c \
    src/getenforce.c \
    src/getfilecon.c \
    src/init.c \
    src/label.c \
    src/label_backends_android.c \
    src/label_file.c \
    src/label_support.c \
    src/load_policy.c \
    src/mapping.c \
    src/matchpathcon.c \
    src/procattr.c \
    src/regex.c \
    src/setexecfilecon.c \
    src/setrans_client.c \
    src/sha1.c \
    src/stringrep.c \

LIBSELINUX_C_OBJ_FILES := \
    $(patsubst %.c,obj/libselinux/%.o,$(filter %.c,$(LIBSELINUX_SRC_FILES)))

LIBSELINUX_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libselinux/%.o,$(filter %.cpp,$(LIBSELINUX_SRC_FILES)))

DIRS += $(dir $(LIBSELINUX_C_OBJ_FILES) $(LIBSELINUX_CXX_OBJ_FILES))

libselinux: $(LIBSELINUX_ARCHIVE)

$(LIBSELINUX_ARCHIVE): $(LIBSELINUX_C_OBJ_FILES) $(LIBSELINUX_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBSELINUX_C_OBJ_FILES): obj/libselinux/%.o: $(srcdir)/selinux/libselinux/%.c | dirs
	$(CC) $(LIBSELINUX_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBSELINUX_CXX_OBJ_FILES): obj/libselinux/%.o: $(srcdir)/selinux/libselinux/%.cpp | dirs
	$(CXX) $(LIBSELINUX_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
