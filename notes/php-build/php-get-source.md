# Get PHP source

- Releases page: [php.net/downloads.php](http://php.net/downloads.php)
- An archvie of 5.6.14: [php.net/get/php-5.6.14.tar.bz2/from/a/mirror](http://php.net/get/php-5.6.14.tar.bz2/from/a/mirror)

```
[[ ! -f php-${php_version}.tar.gz ]] \
  && wget http://us3.php.net/get/php-${php_version}.tar.gz/from/this/mirror -O php-${php_version}.tar.gz
```

### verify source

Install gpg2 and create a personal signing key

- https://help.ubuntu.com/community/GnuPrivacyGuardHowto

```
brew install gnupg2
gpg2 --gen-key
```
- inputs
  - **(1) RSA and RSA (default)**
  - Requested keysize is **2048 bits**
  - Please specify how long the key should be valid.
    - **0 = key does not expire**
    - …
    - <n>y = key expires in n years  
  - Real name: <name>
  - Email address: <email>
  - You need a Passphrase to protect your secret key.    

Locate the public-key-fingerprint for a php developer (depends on which version of php):

```
open https://secure.php.net/downloads.php#gpg-5.5
open https://secure.php.net/downloads.php#gpg-5.6
```

Fetch the developers key via the fingerprint. Given a key output like:

```
pub   2048R/<these-8-chars> 20XX-XX-XX [expires: 20XX-XX-XX]
      Key fingerprint = XXX0 XXX0 XXX0 XXX0 XXX0  YYY0 YYY0 YYY0 YYY0 YYY0
uid                  Jello Jam <jello@php.net>
```

Fetch the key with

```
gpg2 --keyserver pgpkeys.mit.edu --recv-key <these-8-chars>
```

Check that the key was added to the store

```
gpg2 --list-keys php.net
gpg2 --fingerprint php.net
```

Trust the key

```
gpg2 --edit-key <email> trust
```
