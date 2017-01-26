#include <openssl/evp.h>

// From BoringSSL commit 660140206ed32aa217ba3f299debae8d9ac472ec
// BoringSSL is a fork of OpenSSL... see
// https://boringssl.googlesource.com/boringssl/+/master/LICENSE
static int EVP_EncodedLength(size_t *out_len, size_t len) {
  if (len + 2 < len) {
    return 0;
  }
  len += 2;
  len /= 3;
  if (((len << 2) >> 2) != len) {
    return 0;
  }
  len <<= 2;
  if (len + 1 < len) {
    return 0;
  }
  len++;
  *out_len = len;
  return 1;
}
