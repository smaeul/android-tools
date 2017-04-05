# liblog
# =========================================================

LIBLOG_ARCHIVE := obj/liblog/liblog.a

LIBLOG_CFLAGS := \
    -DFAKE_LOG_DEVICE=1 \
    -DLIBLOG_LOG_TAG=1006 \
    -DSNET_EVENT_LOG_TAG=1397638484 \
    -fvisibility=hidden \
    -I$(srcdir)/core/include \
    -I$(srcdir)/core/liblog/include \
    -I$(srcdir)/include \

LIBLOG_CXXFLAGS := \
    -DFAKE_LOG_DEVICE=1 \
    -DLIBLOG_LOG_TAG=1006 \
    -DSNET_EVENT_LOG_TAG=1397638484 \
    -fvisibility=hidden \
    -I$(srcdir)/core/include \
    -I$(srcdir)/core/liblog/include \
    -I$(srcdir)/include \

LIBLOG_SRC_FILES := \
    config_read.c \
    config_write.c \
    fake_log_device.c \
    fake_writer.c \
    local_logger.c \
    log_event_list.c \
    log_event_write.c \
    log_ratelimit.cpp \
    logger_lock.c \
    logger_name.c \
    logger_read.c \
    logger_write.c \
    logprint.c \

LIBLOG_C_OBJ_FILES := \
    $(patsubst %.c,obj/liblog/%.o,$(filter %.c,$(LIBLOG_SRC_FILES)))

LIBLOG_CXX_OBJ_FILES := \
    $(patsubst %.cpp,obj/liblog/%.o,$(filter %.cpp,$(LIBLOG_SRC_FILES)))

DIRS += $(dir $(LIBLOG_C_OBJ_FILES) $(LIBLOG_CXX_OBJ_FILES))

liblog: $(LIBLOG_ARCHIVE)

$(LIBLOG_ARCHIVE): $(LIBLOG_C_OBJ_FILES) $(LIBLOG_CXX_OBJ_FILES) | dirs
	$(AR) rcs $@ $^

$(LIBLOG_C_OBJ_FILES): obj/liblog/%.o: $(srcdir)/core/liblog/%.c | dirs
	$(CC) $(LIBLOG_CFLAGS) $(CFLAGS) -c -o $@ $^

$(LIBLOG_CXX_OBJ_FILES): obj/liblog/%.o: $(srcdir)/core/liblog/%.cpp | dirs
	$(CXX) $(LIBLOG_CXXFLAGS) $(CXXFLAGS) -c -o $@ $^
