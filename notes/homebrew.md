
install modern amp

```
brew install homebrew/php/php70
brew install mysql
brew install apache
```

```
brew services list
```

## php7

* with
  * `--with-cgi` Enable building of the CGI executable (implies --without-fpm)
  * `--with-debug` Compile with debugging symbols
  * `--with-enchant` Build with enchant support
  * `--with-gmp` Build with gmp support
  * `--with-homebrew-apxs` Build against apxs in Homebrew prefix
  * `--with-homebrew-curl` Include Curl support via Homebrew
  * `--with-homebrew-libressl` Include LibreSSL instead of OpenSSL via Homebrew
  * `--with-homebrew-libxml2` Include Libxml2 support via Homebrew
  * `--with-homebrew-libxslt` Include LibXSLT support via Homebrew
  * `--with-imap` Include IMAP extension
  * `--with-libmysql` Include (old-style) libmysql support instead of mysqlnd
  * `--with-mssql` Include MSSQL-DB support
  * `--with-pdo-oci` Include Oracle databases (requries ORACLE_HOME be set)
  * `--with-pear` Build with PEAR
  * `--with-phpdbg` Enable building of the phpdbg SAPI executable (PHP 5.4 and above)
  * `--with-postgresql` Build with postgresql support
  * `--with-thread-safety` Build with thread safety
* without
  * `--without-apache` Disable building of shared Apache 2.0 Handler module
  * `--without-bz2` Build without bz2 support
  * `--without-fpm` Disable building of the fpm SAPI executable
  * `--without-ldap` Build without LDAP support
  * `--without-legacy-mysql` Do not include the deprecated mysql_ functions
  * `--without-mysql` Remove MySQL/MariaDB support
  * `--without-pcntl` Build without Process Control support
  * `--without-unixodbc` Build without unixODBC support
  * `--HEAD` Install HEAD version

### php 7 -m modules

- bcmath
- bz2
- calendar
- Core
- ctype
- curl
- date
- dba
- dom
- exif
- fileinfo
- filter
- ftp
- gd
- gettext
- hash
- iconv
- intl
- json
- ldap
- libxml
- mbstring
- mcrypt
- mysqli
- mysqlnd
- odbc
- openssl
- pcntl
- pcre
- PDO
- pdo_mysql
- PDO_ODBC
- pdo_sqlite
- Phar
- posix
- readline
- Reflection
- session
- shmop
- SimpleXML
- soap
- sockets
- SPL
- sqlite3
- standard
- sysvmsg
- sysvsem
- sysvshm
- tokenizer
- wddx
- xml
- xmlreader
- xmlrpc
- xmlwriter
- xsl
- zip
- zlib

### optional php7 extensions

- amqp
- apcu
- apcu-bc
- ast
- blitz
- ev
- event
- gmagick
- gmp
- hprose
- imagick
- intl
- kafka
- libsodium
- lz4
- lzf
- mailparse
- mcrypt
- mecab
- memcached
- mongodb
- msgpack
- mustache
- oauth
- opcache
- pcntl
- pdo-dblib
- pdo-pgsql
- pspell
- pthreads
- rdkafka
- redis
- snmp
- ssh2
- stats
- swoole
- tidy
- uuid
- v8js
- xdebug
- xxtea
- yaml

### multiple versions of mysql

https://gist.github.com/benlinton/d24471729ed6c2ace731

