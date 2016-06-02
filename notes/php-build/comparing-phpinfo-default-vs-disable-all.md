### comparing phpinfo: default vs. disable-all

```
→ diff phpinfo-*.log
5,6c5,6
< Build Date => Nov 19 2015 15:49:23
< Configure Command =>  './configure'  '--prefix=/Users/markfox/.mybrew/builds/php5.6.15'
---
> Build Date => Nov 21 2015 23:14:27
> Configure Command =>  './configure'  '--prefix=/Users/markfox/.mybrew/builds/php5.6.15' '--disable-cgi' '--disable-short-tags' '--disable-all' '--without-pear'
26c26
< Registered PHP Streams => php, file, glob, data, http, ftp, phar
---
> Registered PHP Streams => php, file, glob, data, http, ftp
28c28
< Registered Stream Filters => convert.iconv.*, string.rot13, string.toupper, string.tolower, string.strip_tags, convert.*, consumed, dechunk
---
> Registered Stream Filters => string.rot13, string.toupper, string.tolower, string.strip_tags, convert.*, consumed, dechunk
132,135d131
< ctype
<
< ctype functions => enabled
<
150,160d145
< dom
<
< DOM/XML => enabled
< DOM/XML API Version => 20031129
< libxml Version => 2.9.2
< HTML Support => enabled
< XPath Support => enabled
< XPointer Support => enabled
< Schema Support => enabled
< RelaxNG Support => enabled
<
165,207d149
< fileinfo
<
< fileinfo support => enabled
< version => 1.0.5
< libmagic => 517
<
< filter
<
< Input Validation and Filtering => enabled
< Revision => $Id: 86120bba568c551914a35636ec408f1e7e66af32 $
<
< Directive => Local Value => Master Value
< filter.default => unsafe_raw => unsafe_raw
< filter.default_flags => no value => no value
<
< hash
<
< hash support => enabled
< Hashing Engines => md2 md4 md5 sha1 sha224 sha256 sha384 sha512 ripemd128 ripemd160 ripemd256 ripemd320 whirlpool tiger128,3 tiger160,3 tiger192,3 tiger128,4 tiger160,4 tiger192,4 snefru snefru256 gost gost-crypto adler32 crc32 crc32b fnv132 fnv1a32 fnv164 fnv1a64 joaat haval128,3 haval160,3 haval192,3 haval224,3 haval256,3 haval128,4 haval160,4 haval192,4 haval224,4 haval256,4 haval128,5 haval160,5 haval192,5 haval224,5 haval256,5
<
< iconv
<
< iconv support => enabled
< iconv implementation => libiconv
< iconv library version => 1.11
<
< Directive => Local Value => Master Value
< iconv.input_encoding => no value => no value
< iconv.internal_encoding => no value => no value
< iconv.output_encoding => no value => no value
<
< json
<
< json support => enabled
< json version => 1.2.1
<
< libxml
<
< libXML support => active
< libXML Compiled Version => 2.9.2
< libXML Loaded Version => 20902
< libXML streams => enabled
<
217,252d158
< PDO
<
< PDO support => enabled
< PDO drivers => sqlite
<
< pdo_sqlite
<
< PDO Driver for SQLite 3.x => enabled
< SQLite Library => 3.8.10.2
<
< Phar
<
< Phar: PHP Archive support => enabled
< Phar EXT version => 2.0.2
< Phar API version => 1.1.1
< SVN revision => $Id: 72d7e004b07d106bb1ef7c5663a186cbae621385 $
< Phar-based phar archives => enabled
< Tar-based phar archives => enabled
< ZIP-based phar archives => enabled
< gzip compression => disabled (install ext/zlib)
< bzip2 compression => disabled (install pecl/bz2)
< OpenSSL support => disabled (install ext/openssl)
<
<
< Phar based on pear/PHP_Archive, original concept by Davey Shafik.
< Phar fully realized by Gregory Beaver and Marcus Boerger.
< Portions of tar implementation Copyright (c) 2003-2009 Tim Kientzle.
< Directive => Local Value => Master Value
< phar.cache_list => no value => no value
< phar.readonly => On => On
< phar.require_hash => On => On
<
< posix
<
< Revision => $Id: 5d20de77687b7d961b15450873fa23b9e64a136a $
<
258,301d163
< session
<
< Session Support => enabled
< Registered save handlers => files user
< Registered serializer handlers => php_serialize php php_binary
<
< Directive => Local Value => Master Value
< session.auto_start => Off => Off
< session.cache_expire => 180 => 180
< session.cache_limiter => nocache => nocache
< session.cookie_domain => no value => no value
< session.cookie_httponly => Off => Off
< session.cookie_lifetime => 0 => 0
< session.cookie_path => / => /
< session.cookie_secure => Off => Off
< session.entropy_file => /dev/urandom => /dev/urandom
< session.entropy_length => 32 => 32
< session.gc_divisor => 100 => 100
< session.gc_maxlifetime => 1440 => 1440
< session.gc_probability => 1 => 1
< session.hash_bits_per_character => 4 => 4
< session.hash_function => 0 => 0
< session.name => PHPSESSID => PHPSESSID
< session.referer_check => no value => no value
< session.save_handler => files => files
< session.save_path => no value => no value
< session.serialize_handler => php => php
< session.upload_progress.cleanup => On => On
< session.upload_progress.enabled => On => On
< session.upload_progress.freq => 1% => 1%
< session.upload_progress.min_freq => 1 => 1
< session.upload_progress.name => PHP_SESSION_UPLOAD_PROGRESS => PHP_SESSION_UPLOAD_PROGRESS
< session.upload_progress.prefix => upload_progress_ => upload_progress_
< session.use_cookies => On => On
< session.use_only_cookies => On => On
< session.use_strict_mode => Off => Off
< session.use_trans_sid => 0 => 0
<
< SimpleXML
<
< Simplexml support => enabled
< Revision => $Id: 6b8e23a01a85046737ef7d31346da5164505c179 $
< Schema support => enabled
<
308,316d169
< sqlite3
<
< SQLite3 support => enabled
< SQLite3 module version => 0.7-dev
< SQLite Library => 3.8.10.2
<
< Directive => Local Value => Master Value
< sqlite3.extension_dir => no value => no value
<
334,351d186
< tokenizer
<
< Tokenizer Support => enabled
<
< xml
<
< XML Support => active
< XML Namespace Support => active
< libxml2 Version => 2.9.2
<
< xmlreader
<
< XMLReader => enabled
<
< xmlwriter
<
< XMLWriter => enabled
<
```
