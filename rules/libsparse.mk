# libsparse
# =========================================================

LIBSPARSE_ARCHIVE := obj/libsparse/libsparse.a

LIBSPARSE_CFLAGS := \
    -I$(srcdir)/core/libsparse/include \

LIBSPARSE_SRC_FILES := \
    backed_block.c \
    output_file.c \
    sparse.c \
    sparse_crc32.c \
    sparse_err.c \
    sparse_read.c \

LIBSPARSE_C_OBJ_FILES := \
    $(patsubst %.c,obj/libsparse/%.o,$(filter %.c,$(LIBSPARSE_SRC_FILES)))

LIBSPARSE_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libsparse/%.o,$(filter %.cpp,$(LIBSPARSE_SRC_FILES)))

DIRS += $(dir $(LIBSPARSE_C_OBJ_FILES) $(LIBSPARSE_CXX_OBJ_FILES))

libsparse: $(LIBSPARSE_ARCHIVE)

$(LIBSPARSE_ARCHIVE): $(LIBSPARSE_C_OBJ_FILES) $(LIBSPARSE_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBSPARSE_C_OBJ_FILES): obj/libsparse/%.o: $(srcdir)/core/libsparse/%.c | dirs
	$(CC) $(LIBSPARSE_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBSPARSE_CXX_OBJ_FILES): obj/libsparse/%.o: $(srcdir)/core/libsparse/%.cpp | dirs
	$(CXX) $(LIBSPARSE_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^

# simg2img host tool
# =========================================================

SIMG2IMG_BINARY := obj/simg2img/simg2img

SIMG2IMG_CFLAGS := \
    -I$(srcdir)/core/libsparse/include \

SIMG2IMG_LDFLAGS := \
    -lz \

SIMG2IMG_LIBS := \
    libsparse \

SIMG2IMG_SRC_FILES := \
    simg2img.c \
    sparse_crc32.c \

SIMG2IMG_LIB_DEPS := \
    $(foreach lib,$(SIMG2IMG_LIBS),obj/$(lib)/$(lib).a)

SIMG2IMG_OBJ_FILES := \
    $(patsubst %.c,obj/simg2img/%.o,$(SIMG2IMG_SRC_FILES))

BINS += $(SIMG2IMG_BINARY)
DIRS += $(dir $(SIMG2IMG_OBJ_FILES))

simg2img: $(SIMG2IMG_BINARY)

$(SIMG2IMG_BINARY): $(SIMG2IMG_OBJ_FILES) $(SIMG2IMG_LIB_DEPS) | dirs
	$(CC) $(SIMG2IMG_CFLAGS) $(CFLAGS) -o $@ $^ $(SIMG2IMG_LDFLAGS) $(LDFLAGS)

$(SIMG2IMG_OBJ_FILES): obj/simg2img/%.o: $(srcdir)/core/libsparse/%.c | dirs
	$(CC) $(SIMG2IMG_CFLAGS) $(CFLAGS) -c -o $@ $^

# img2simg host tool
# =========================================================

IMG2SIMG_BINARY := obj/img2simg/img2simg

IMG2SIMG_CFLAGS := \
    -I$(srcdir)/core/libsparse/include \

IMG2SIMG_LDFLAGS := \
    -lz \

IMG2SIMG_LIBS := \
    libsparse \

IMG2SIMG_SRC_FILES := \
    img2simg.c \
    sparse_crc32.c \

IMG2SIMG_LIB_DEPS := \
    $(foreach lib,$(IMG2SIMG_LIBS),obj/$(lib)/$(lib).a)

IMG2SIMG_OBJ_FILES := \
    $(patsubst %.c,obj/img2simg/%.o,$(IMG2SIMG_SRC_FILES))

BINS += $(IMG2SIMG_BINARY)
DIRS += $(dir $(IMG2SIMG_OBJ_FILES))

img2simg: $(IMG2SIMG_BINARY)

$(IMG2SIMG_BINARY): $(IMG2SIMG_OBJ_FILES) $(IMG2SIMG_LIB_DEPS) | dirs
	$(CC) $(IMG2SIMG_CFLAGS) $(CFLAGS) -o $@ $^ $(IMG2SIMG_LDFLAGS) $(LDFLAGS)

$(IMG2SIMG_OBJ_FILES): obj/img2simg/%.o: $(srcdir)/core/libsparse/%.c | dirs
	$(CC) $(IMG2SIMG_CFLAGS) $(CFLAGS) -c -o $@ $^
