# libpcre
# =========================================================

LIBPCRE_ARCHIVE := obj/libpcre/libpcre.a

LIBPCRE_CFLAGS := \
    -DHAVE_CONFIG_H \
    -I$(srcdir)/pcre/include \
    -I$(srcdir)/pcre/include_internal \

LIBPCRE_SRC_FILES := \
    dist2/src/pcre2_auto_possess.c \
    dist2/src/pcre2_chartables.c \
    dist2/src/pcre2_compile.c \
    dist2/src/pcre2_config.c \
    dist2/src/pcre2_context.c \
    dist2/src/pcre2_dfa_match.c \
    dist2/src/pcre2_error.c \
    dist2/src/pcre2_find_bracket.c \
    dist2/src/pcre2_jit_compile.c \
    dist2/src/pcre2_maketables.c \
    dist2/src/pcre2_match.c \
    dist2/src/pcre2_match_data.c \
    dist2/src/pcre2_newline.c \
    dist2/src/pcre2_ord2utf.c \
    dist2/src/pcre2_pattern_info.c \
    dist2/src/pcre2_serialize.c \
    dist2/src/pcre2_string_utils.c \
    dist2/src/pcre2_study.c \
    dist2/src/pcre2_substitute.c \
    dist2/src/pcre2_substring.c \
    dist2/src/pcre2_tables.c \
    dist2/src/pcre2_ucd.c \
    dist2/src/pcre2_valid_utf.c \
    dist2/src/pcre2_xclass.c \

LIBPCRE_C_OBJ_FILES := \
    $(patsubst %.c,obj/libpcre/%.o,$(filter %.c,$(LIBPCRE_SRC_FILES)))

LIBPCRE_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libpcre/%.o,$(filter %.cpp,$(LIBPCRE_SRC_FILES)))

DIRS += $(dir $(LIBPCRE_C_OBJ_FILES) $(LIBPCRE_CXX_OBJ_FILES))

libpcre: $(LIBPCRE_ARCHIVE)

$(LIBPCRE_ARCHIVE): $(LIBPCRE_C_OBJ_FILES) $(LIBPCRE_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBPCRE_C_OBJ_FILES): obj/libpcre/%.o: $(srcdir)/pcre/%.c | dirs
	$(CC) $(LIBPCRE_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBPCRE_CXX_OBJ_FILES): obj/libpcre/%.o: $(srcdir)/pcre/%.cpp | dirs
	$(CXX) $(LIBPCRE_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
