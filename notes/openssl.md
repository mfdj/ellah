```
→ brew ls openssl
/usr/local/Cellar/openssl/1.0.2f/bin/c_rehash
/usr/local/Cellar/openssl/1.0.2f/bin/openssl
/usr/local/Cellar/openssl/1.0.2f/include/openssl/ (75 files)
/usr/local/Cellar/openssl/1.0.2f/lib/libcrypto.1.0.0.dylib
/usr/local/Cellar/openssl/1.0.2f/lib/libssl.1.0.0.dylib
/usr/local/Cellar/openssl/1.0.2f/lib/engines/ (12 files)
/usr/local/Cellar/openssl/1.0.2f/lib/pkgconfig/ (3 files)
/usr/local/Cellar/openssl/1.0.2f/lib/ (4 other files)
/usr/local/Cellar/openssl/1.0.2f/share/man/ (1548 files)
```

```
openssl_source=$(find `brew --prefix`/Cellar/openssl -d 1 | tail -1)

./configure \
  --prefix=${env_php_path} \
  --with-openssl=${openssl_source}
```

```
Undefined symbols for architecture x86_64:
  "_PKCS5_PBKDF2_HMAC", referenced from:
      _zif_openssl_pbkdf2 in openssl.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [sapi/cli/php] Error 1
```

### Solution

- `brew link libxml2 --force`
- and need to delete the build folder (decided to do this by default, since it doesn't seem to help to leave it around)
