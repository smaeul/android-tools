# libutils
# =========================================================

LIBUTILS_ARCHIVE := obj/libutils/libutils.a

LIBUTILS_CXXFLAGS := \
    -DLIBUTILS_NATIVE=1 \
    -fvisibility=protected \
    -I$(srcdir)/core/include \

LIBUTILS_SRC_FILES := \
    CallStack.cpp \
    FileMap.cpp \
    JenkinsHash.cpp \
    LinearTransform.cpp \
    Log.cpp \
    Printer.cpp \
    ProcessCallStack.cpp \
    PropertyMap.cpp \
    SharedBuffer.cpp \
    Static.cpp \
    StopWatch.cpp \
    StrongPointer.cpp \
    SystemClock.cpp \
    Timers.cpp \
    Tokenizer.cpp \
    Unicode.cpp \

LIBUTILS_C_OBJ_FILES := \
    $(patsubst %.c,obj/libutils/%.o,$(filter %.c,$(LIBUTILS_SRC_FILES)))

LIBUTILS_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/libutils/%.o,$(filter %.cpp,$(LIBUTILS_SRC_FILES)))

DIRS += $(dir $(LIBUTILS_C_OBJ_FILES) $(LIBUTILS_CXX_OBJ_FILES))

libutils: $(LIBUTILS_ARCHIVE)

$(LIBUTILS_ARCHIVE): $(LIBUTILS_C_OBJ_FILES) $(LIBUTILS_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBUTILS_C_OBJ_FILES): obj/libutils/%.o: $(srcdir)/core/libutils/%.c | dirs
	$(CC) $(LIBUTILS_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBUTILS_CXX_OBJ_FILES): obj/libutils/%.o: $(srcdir)/core/libutils/%.cpp | dirs
	$(CXX) $(LIBUTILS_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
