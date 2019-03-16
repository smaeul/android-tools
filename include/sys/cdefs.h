#if defined(__GLIBC__)
#include_next <sys/cdefs.h>
#else

#ifdef __cplusplus
#define __BEGIN_DECLS extern "C" {
#define __END_DECLS }
#else
#define __BEGIN_DECLS
#define __END_DECLS
#endif

#ifndef TEMP_FAILURE_RETRY
#define TEMP_FAILURE_RETRY(exp)                                                \
  ({                                                                           \
    typeof(exp) _rc;                                                           \
    do {                                                                       \
      _rc = (exp);                                                             \
    } while (_rc == -1 && errno == EINTR);                                     \
    _rc;                                                                       \
  })
#endif

#endif
