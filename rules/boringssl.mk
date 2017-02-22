# boringssl
# =========================================================

DIRS += obj/boringssl

obj/libcrypto/libcrypto.a: | dirs
	(cd obj/boringssl && \
		cmake $(srcdir)/boringssl \
		-DCMAKE_C_COMPILER="$(CC)" \
		-DCMAKE_C_FLAGS="$(CFLAGS)" \
		-DCMAKE_CXX_COMPILER="$(CXX)" \
		-DCMAKE_CXX_FLAGS="$(CXXFLAGS)" \
		-DCMAKE_RULE_MESSAGES=0 \
		-DCMAKE_VERBOSE_MAKEFILE=1)
	$(MAKE) -C obj/boringssl crypto
	ln -s boringssl/crypto obj/libcrypto
