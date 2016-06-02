# compiling php from source

## basic build

```
./configure
make
make install
```
You got some php with the default `./configure` settings:

- Installs everything (bin, include, lib) under `/usr/local` (no bueno)
- Has the following extensions: Core, ctype, date, dom, ereg, fileinfo, filter, hash, iconv, json, libxml, pcre, PDO, pdo_sqlite, Phar, posix, Reflection, session, SimpleXML, SPL, sqlite3, standard, tokenizer, xml, xmlreader, xmlwriter

## custom build configuration

GNU Autoconf generates the configure script. It uses flags to configure itself like `--param=argument` and `--enable-thing` and `--disable-thing` and `--with-lib-thing=<path>`

To get a feel for the options for php run:

```
./configure --help=short
```

List of the high-level configuration sections:

- [SAPI](https://en.wikipedia.org/wiki/Server_Application_Programming_Interface) modules
- General settings
- Extensions
- PEAR
- Zend
- TRSM
- Libtool

### Abridged configure options

There are many, many options to configure with PHP 5.6 — I've added some notes about the more modern and relevant ones.

**Installation Directories**

A core aspect of the configure script is the `$PREFIX` environment variable which is the path where the compiled code will be installed — it can be set with:

```
./configure --prefix=</usr/local>
```

There many other installation paths but they all seem to incorporate `$PREFIX` so setting the prefix should be enough to keep everything together and easily organized.

**SAPI**

apxs2 = [Apache2 Extension Tool](https://httpd.apache.org/docs/2.2/programs/apxs.html) — for building the `mod_php` shared object

```
--with-apxs2=<path>
```

fpm = [FastCGI Process Manager](http://php.net/manual/en/install.fpm.php)

```
--enable-fpm
--with-fpm-user=<user>
--with-fpm-group=<group>
--with-fpm-systemd
--with-fpm-acl
```

phpdbg = [interactive debugger](http://php.net/manual/en/migration56.new-features.php#migration56.new-features.phpdbg) (inspired by [GNU Debugger](https://www.gnu.org/software/gdb/))

```
--enable-phpdbg
--enable-phpdbg-debug
```

Don't use CGI: it's ancient and [vulnerable](https://www.rapid7.com/db/modules/exploit/multi/http/php_cgi_arg_injection).

```
--disable-cgi
```

Other options include building against [aolserver](https://en.wikipedia.org/wiki/AOLserver), apache v1, [caudium](http://caudium.net/space/start), [continuity](http://search.cpan.org/~awwaiid/Continuity/lib/Continuity.pm), [zeus](https://en.wikipedia.org/wiki/Zeus_Web_Server), [litespeed](https://www.litespeedtech.com/products/litespeed-web-server/overview), [milter](https://en.wikipedia.org/wiki/Milter), [netscape application server](https://en.wikipedia.org/wiki/Netscape_Server_Application_Programming_Interface), [phttpd](http://www.lysator.liu.se/~pen/phttpd/), [pi3web](http://pi3web.sourceforge.net/pi3web/), [roxen](https://en.wikipedia.org/wiki/Roxen_(web_server)), [thttpd](http://acme.com/software/thttpd/), [tux](https://en.wikipedia.org/wiki/TUX_web_server), [webjames](http://www.riscos.info/index.php/WebJames) plus a bunch of weird options that mostly agumented build against apache

**General Settings**

```
--disable-short-tags    Disable the short-form <? start tag by default
```

```
--enable-debug          Compile with debugging symbols
--enable-sigchild       Enable PHP's own SIGCHLD handler
--enable-dmalloc        Enable dmalloc
--disable-ipv6          Disable IPv6 support
--enable-dtrace         Enable DTrace support
--enable-fd-setsize     Set size of descriptor sets
```

**Extensions**

```
--disable-all           Disable all extensions which are enabled by default
```

or disable certain modules

```
--disable-libxml        Disable LIBXML support
--disable-ctype         Disable ctype functions
--disable-inifile       DBA: INI support (bundled)
--disable-flatfile      DBA: FlatFile support (bundled)
--disable-dom           Disable DOM support
--disable-fileinfo      Disable fileinfo support
--disable-filter        Disable input filter support
--disable-hash          Disable hash support
--disable-json          Disable JavaScript Object Serialization support
--disable-mbregex       MBSTRING: Disable multibyte regex support
--disable-mbregex-backtrack
--disable-pdo           Disable PHP Data Objects support
--disable-phar          Disable phar support
--disable-posix         Disable POSIX-like functions
--disable-session       Disable session support
--disable-simplexml     Disable SimpleXML support
--disable-tokenizer     Disable tokenizer support
--disable-xml           Disable XML support
--disable-xmlreader     Disable XMLReader support
--disable-xmlwriter     Disable XMLWriter support
--disable-mysqlnd-compression-support
```

Then enable

```
--enable-intl           Enable internationalization support
--with-icu-dir=DIR      Specify where ICU libraries and headers can be found
```

```
--with-libxml-dir=DIR   LIBXML: libxml2 install prefix
```

```
--with-openssl=DIR      Include OpenSSL support (requires OpenSSL >= 0.9.6)
--with-system-ciphers   OPENSSL: Use system default cipher list instead of hardcoded value
```

```
--with-pcre-regex=DIR   Include Perl Compatible Regular Expressions support.
                        DIR is the PCRE install prefix BUNDLED
```

```
--with-zlib=DIR         Include ZLIB support (requires zlib >= 1.0.9)
--with-zlib-dir=<DIR>   Define the location of zlib install directory
--with-bz2=DIR          Include BZip2 support
```

```
--enable-bcmath         Enable bc style precision math functions
```

```
--with-curl=DIR         Include cURL support
```

```
--with-enchant=DIR      Include enchant support.
                        GNU Aspell version 1.1.3 or higher required.
```

```
--enable-exif           Enable EXIF (metadata from images) support
--with-gd=DIR           Include GD support.  DIR is the GD library base
                        install directory BUNDLED
--with-vpx-dir=DIR      GD: Set the path to libvpx install prefix
--with-jpeg-dir=DIR     GD: Set the path to libjpeg install prefix
--with-png-dir=DIR      GD: Set the path to libpng install prefix
--with-zlib-dir=DIR     GD: Set the path to libz install prefix
--with-xpm-dir=DIR      GD: Set the path to libXpm install prefix
--with-freetype-dir=DIR GD: Set the path to FreeType 2 install prefix
--with-t1lib=DIR        GD: Include T1lib support. T1lib version >= 5.0.0 required
--enable-gd-native-ttf  GD: Enable TrueType string function
--enable-gd-jis-conv    GD: Enable JIS-mapped Japanese font support
--with-gettext=DIR      Include GNU gettext support
--with-gmp=DIR          Include GNU MP support
--with-mhash=DIR        Include mhash support
--disable-hash          Disable hash support
--without-iconv=DIR     Exclude iconv support
--with-imap=DIR         Include IMAP support. DIR is the c-client install prefix
--with-kerberos=DIR     IMAP: Include Kerberos support. DIR is the Kerberos install prefix
--with-imap-ssl=DIR     IMAP: Include SSL support. DIR is the OpenSSL install prefix
--with-interbase=DIR    Include InterBase support.  DIR is the InterBase base
                        install directory /usr/interbase
--with-ldap=DIR         Include LDAP support
--with-ldap-sasl=DIR    LDAP: Include Cyrus SASL support
--enable-mbstring       Enable multibyte string support
--disable-mbregex       MBSTRING: Disable multibyte regex support
--disable-mbregex-backtrack
                        MBSTRING: Disable multibyte regex backtrack check
--with-libmbfl=DIR      MBSTRING: Use external libmbfl.  DIR is the libmbfl base
                        install directory BUNDLED
--with-onig=DIR         MBSTRING: Use external oniguruma. DIR is the oniguruma install prefix.
                        If DIR is not set, the bundled oniguruma will be used
--with-mcrypt=DIR       Include mcrypt support
--with-mssql=DIR        Include MSSQL-DB support.  DIR is the FreeTDS home
                        directory /usr/local/freetds
--with-mysql=DIR        Include MySQL support.  DIR is the MySQL base
                        directory, if no DIR is passed or the value is
                        mysqlnd the MySQL native driver will be used
--with-mysql-sock=SOCKPATH
                        MySQL/MySQLi/PDO_MYSQL: Location of the MySQL unix socket pointer.
                        If unspecified, the default locations are searched
--with-zlib-dir=DIR     MySQL: Set the path to libz install prefix
--with-mysqli=FILE      Include MySQLi support.  FILE is the path
                        to mysql_config.  If no value or mysqlnd is passed
                        as FILE, the MySQL native driver will be used
--enable-embedded-mysqli
                        MYSQLi: Enable embedded support
                        Note: Does not work with MySQL native driver!
--with-oci8=DIR         Include Oracle Database OCI8 support. DIR defaults to $ORACLE_HOME.
                        Use --with-oci8=instantclient,/path/to/instant/client/lib
                        to use an Oracle Instant Client installation
--with-odbcver=HEX      Force support for the passed ODBC version. A hex number is expected, default 0x0300.
                           Use the special value of 0 to prevent an explicit ODBCVER to be defined.
--with-adabas=DIR       Include Adabas D support /usr/local
--with-sapdb=DIR        Include SAP DB support /usr/local
--with-solid=DIR        Include Solid support /usr/local/solid
--with-ibm-db2=DIR      Include IBM DB2 support /home/db2inst1/sqllib
--with-ODBCRouter=DIR   Include ODBCRouter.com support /usr
--with-empress=DIR      Include Empress support \$EMPRESSPATH
                        (Empress Version >= 8.60 required)
--with-empress-bcs=DIR
                        Include Empress Local Access support \$EMPRESSPATH
                        (Empress Version >= 8.60 required)
--with-birdstep=DIR     Include Birdstep support /usr/local/birdstep
--with-custom-odbc=DIR  Include user defined ODBC support. DIR is ODBC install base
                        directory /usr/local. Make sure to define CUSTOM_ODBC_LIBS and
                        have some odbc.h in your include dirs. f.e. you should define
                        following for Sybase SQL Anywhere 5.5.00 on QNX, prior to
                        running this configure script:
                          CPPFLAGS=\"-DODBC_QNX -DSQLANY_BUG\"
                          LDFLAGS=-lunix
                          CUSTOM_ODBC_LIBS=\"-ldblib -lodbc\"
--with-iodbc=DIR        Include iODBC support /usr/local
--with-esoob=DIR        Include Easysoft OOB support /usr/local/easysoft/oob/client
--with-unixODBC=DIR     Include unixODBC support /usr/local
--with-dbmaker=DIR      Include DBMaker support
--enable-opcache        Enable Zend OPcache support
--enable-pcntl          Enable pcntl support (CLI/CGI only)
--disable-pdo           Disable PHP Data Objects support
--with-pdo-dblib=DIR    PDO: DBLIB-DB support.  DIR is the FreeTDS home directory
--with-pdo-firebird=DIR PDO: Firebird support.  DIR is the Firebird base
                        install directory /opt/firebird
--with-pdo-mysql=DIR    PDO: MySQL support. DIR is the MySQL base directory
                        If no value or mysqlnd is passed as DIR, the
                        MySQL native driver will be used
--with-zlib-dir=DIR     PDO_MySQL: Set the path to libz install prefix
--with-pdo-oci=DIR      PDO: Oracle OCI support. DIR defaults to \$ORACLE_HOME.
                        Use --with-pdo-oci=instantclient,prefix,version
                        for an Oracle Instant Client SDK.
                        For example on Linux with 11.2 RPMs use:
                          --with-pdo-oci=instantclient,/usr,11.2
                        With 10.2 RPMs use:
                          --with-pdo-oci=instantclient,/usr,10.2.0.4
--with-pdo-odbc=flavour,dir
                        PDO: Support for 'flavour' ODBC driver.
      include and lib dirs are looked for under 'dir'.

      'flavour' can be one of:  ibm-db2, iODBC, unixODBC, generic
      If ',dir' part is omitted, default for the flavour
      you have selected will be used. e.g.:

        --with-pdo-odbc=unixODBC

      will check for unixODBC under /usr/local. You may attempt
      to use an otherwise unsupported driver using the \"generic\"
      flavour.  The syntax for generic ODBC support is:

        --with-pdo-odbc=generic,dir,libname,ldflags,cflags

      When built as 'shared' the extension filename is always pdo_odbc.so
--with-pdo-pgsql=DIR    PDO: PostgreSQL support.  DIR is the PostgreSQL base
                        install directory or the path to pg_config
--without-pdo-sqlite=DIR
                        PDO: sqlite 3 support.  DIR is the sqlite base
                        install directory BUNDLED
--with-pgsql=DIR        Include PostgreSQL support.  DIR is the PostgreSQL
                        base install directory or the path to pg_config
--disable-phar          Disable phar support
--disable-posix         Disable POSIX-like functions
--with-pspell=DIR       Include PSPELL support.
                        GNU Aspell version 0.50.0 or higher required
--with-libedit=DIR      Include libedit readline replacement (CLI/CGI only)
--with-readline=DIR     Include readline support (CLI/CGI only)
--with-recode=DIR       Include recode support
--disable-session       Disable session support
--with-mm=DIR           SESSION: Include mm support for session storage
--enable-shmop          Enable shmop support
--disable-simplexml     Disable SimpleXML support
--with-libxml-dir=DIR   SimpleXML: libxml2 install prefix
--with-snmp=DIR         Include SNMP support
--with-openssl-dir=DIR  SNMP: openssl install prefix
--enable-soap           Enable SOAP support
--with-libxml-dir=DIR   SOAP: libxml2 install prefix
--enable-sockets        Enable sockets support
--with-sybase-ct=DIR    Include Sybase-CT support.  DIR is the Sybase home
                        directory /home/sybase
--enable-sysvmsg        Enable sysvmsg support
--enable-sysvsem        Enable System V semaphore support
--enable-sysvshm        Enable the System V shared memory support
--with-tidy=DIR         Include TIDY support
--disable-tokenizer     Disable tokenizer support
--enable-wddx           Enable WDDX support
--with-libxml-dir=DIR   WDDX: libxml2 install prefix
--with-libexpat-dir=DIR WDDX: libexpat dir for XMLRPC-EPI (deprecated)
--disable-xml           Disable XML support
--with-libxml-dir=DIR   XML: libxml2 install prefix
--with-libexpat-dir=DIR XML: libexpat install prefix (deprecated)
--disable-xmlreader     Disable XMLReader support
--with-libxml-dir=DIR   XMLReader: libxml2 install prefix
--with-xmlrpc=DIR       Include XMLRPC-EPI support
--with-libxml-dir=DIR   XMLRPC-EPI: libxml2 install prefix
--with-libexpat-dir=DIR XMLRPC-EPI: libexpat dir for XMLRPC-EPI (deprecated)
--with-iconv-dir=DIR    XMLRPC-EPI: iconv dir for XMLRPC-EPI
--disable-xmlwriter     Disable XMLWriter support
--with-libxml-dir=DIR   XMLWriter: libxml2 install prefix
--with-xsl=DIR          Include XSL support.  DIR is the libxslt base
                        install directory (libxslt >= 1.1.0 required)
--enable-zip            Include Zip read/write support
--with-zlib-dir=DIR     ZIP: Set the path to libz install prefix
--with-pcre-dir         ZIP: pcre install prefix
--with-libzip=DIR       ZIP: use libzip
--enable-mysqlnd        Enable mysqlnd explicitly, will be done implicitly
                        when required by other extensions
--disable-mysqlnd-compression-support
                        Disable support for the MySQL compressed protocol in mysqlnd
--with-zlib-dir=DIR     mysqlnd: Set the path to libz install prefix
```

**Extension cruft**

```
--enable-ftp            Enable FTP support
```

**PEAR/PECL**

```
--with-pear=DIR         Install PEAR in DIR [PREFIX/lib/php]
--without-pear          Do not install PEAR
```

Without PEAR means without PECL too.

If `--disable-all` is passed then `--with-pear` is required to install pear/pecl — (`--with-pear=PATH` can accept a custom path but best to let it use the default `PREFIX/lib/php`)

**Zend**

[Zend Signals RFC (available since 5.4)](https://wiki.php.net/rfc/zendsignals)

```
--with-zend-vm=TYPE     Set virtual machine dispatch method. Type is
                        one of "CALL", "SWITCH" or "GOTO" TYPE=CALL
--enable-maintainer-zts Enable thread safety - for code maintainers only!!
--disable-inline-optimization
                        If building zend_execute.lo fails, try this switch
--enable-zend-signals   Use zend signal handling
```

**TSRM**

[Thread Safe Resource Manager](http://php.net/manual/en/internals2.memory.tsrm.php)

```
--with-tsrm-pth=pth-config
                        Use GNU Pth
--with-tsrm-st          Use SGI's State Threads
--with-tsrm-pthreads    Use POSIX threads (default)
```

**Libtool**

[GNU Libtool](http://www.gnu.org/software/libtool/)

```
--enable-shared=PKGS    Build shared libraries default=yes
--enable-static=PKGS    Build static libraries default=yes
--enable-fast-install=PKGS
                        Optimize for fast installation default=yes
--with-gnu-ld           Assume the C compiler uses GNU ld default=no
--disable-libtool-lock  Avoid locking (might break parallel builds)
--with-pic              Try to use only PIC/non-PIC objects default=use both
--with-tags=TAGS        Include additional configurations automatic
```
