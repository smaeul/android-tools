# libbase
# =========================================================

LIBBASE_ARCHIVE := obj/libbase/libbase.a

LIBBASE_CXXFLAGS := \
    -DDEFFILEMODE=0666 \
    -D'getprogname()=program_invocation_short_name' \
    -I$(srcdir)/boringssl/include \
    -I$(srcdir)/core/base/include \
    -I$(srcdir)/core/include \
    -Wexit-time-destructors \

LIBBASE_SRC_FILES := \
    errors_unix.cpp \
    file.cpp \
    logging.cpp \
    parsenetaddress.cpp \
    quick_exit.cpp \
    stringprintf.cpp \
    strings.cpp \
    test_utils.cpp \

LIBBASE_OBJ_FILES := \
    $(patsubst %.cpp,obj/libbase/%.o,$(LIBBASE_SRC_FILES))

DIRS += $(dir $(LIBBASE_OBJ_FILES))

libbase: $(LIBBASE_ARCHIVE)

$(LIBBASE_ARCHIVE): $(LIBBASE_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBBASE_OBJ_FILES): obj/libbase/%.o: $(srcdir)/core/base/%.cpp | dirs
	$(CXX) $(LIBBASE_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
