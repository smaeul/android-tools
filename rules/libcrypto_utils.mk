# libcrypto_utils
# =========================================================

LIBCRYPTO_UTILS_ARCHIVE := obj/libcrypto_utils/libcrypto_utils.a

LIBCRYPTO_UTILS_CFLAGS := \
    -I$(srcdir)/boringssl/include \
    -I$(srcdir)/core/libcrypto_utils/include \

LIBCRYPTO_UTILS_SRC_FILES := \
    android_pubkey.c \

LIBCRYPTO_UTILS_C_OBJ_FILES := \
    $(patsubst %.c,obj/libcrypto_utils/%.o,$(filter %.c,$(LIBCRYPTO_UTILS_SRC_FILES)))

LIBCRYPTO_UTILS_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libcrypto_utils/%.o,$(filter %.cpp,$(LIBCRYPTO_UTILS_SRC_FILES)))

DIRS += $(dir $(LIBCRYPTO_UTILS_C_OBJ_FILES) $(LIBCRYPTO_UTILS_CXX_OBJ_FILES))

libcrypto_utils: $(LIBCRYPTO_UTILS_ARCHIVE)

$(LIBCRYPTO_UTILS_ARCHIVE): $(LIBCRYPTO_UTILS_C_OBJ_FILES) $(LIBCRYPTO_UTILS_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBCRYPTO_UTILS_C_OBJ_FILES): obj/libcrypto_utils/%.o: $(srcdir)/core/libcrypto_utils/%.c | dirs
	$(CC) $(LIBCRYPTO_UTILS_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBCRYPTO_UTILS_CXX_OBJ_FILES): obj/libcrypto_utils/%.o: $(srcdir)/core/libcrypto_utils/%.cpp | dirs
	$(CXX) $(LIBCRYPTO_UTILS_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
