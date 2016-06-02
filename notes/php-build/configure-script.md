
## Comparing default production and development php.inis

At the root of the php-src you will find `php.ini-development` and `php.ini-production`

By default php is configured to look for php.ini in the folder `/php-install-prefix/lib` — this can be configured when compiling with the flag `--with-config-file-path=<path>`

```
$ diff ./php.ini-{production,development}
```

**; This is php.ini-production INI file.**<br/>
; This is php.ini-development INI file.

**error\_reporting = E\_ALL & ~E\_DEPRECATED & ~E\_STRICT**<br/>
error\_reporting = E\_ALL

**display\_errors = Off**<br/>
display\_errors = On

**display\_startup\_errors = Off**<br/>
display\_startup\_errors = On

**track\_errors = Off**<br>
track\_errors = On

**mysqlnd.collect\_memory\_statistics = Off**
mysqlnd.collect\_memory\_statistics = On

## Default configuration

```
./configure
make
make install
```

**[PHP Modules]**

- Core
- ctype
- date
- dom
- ereg
- fileinfo
- filter
- hash
- iconv
- json
- libxml
- pcre
- PDO
- pdo_sqlite
- Phar
- posix
- Reflection
- session
- SimpleXML
- SPL
- sqlite3
- standard
- tokenizer
- xml
- xmlreader
- xmlwriter

**[Zend Modules]**

- (none)

## Minimal configuration

```
./configure \
   --disable-cgi \
   --disable-short-tags \
   --disable-all
```

**[PHP Modules]**

- Core
- date
- ereg
- pcre
- Reflection
- SPL
- standard

**[Zend Modules]**

- (none)

## Conclusions

### PHP 5 skeleton functionality

| module                                  | notes |
| ---                                     | ---   |
| Core                                    | Obviously. |
| [date](http://php.net/manual/en/ref.datetime.php) | all of the date and time functions |
| [ereg](http://php.net/ereg)             | _This function has been DEPRECATED as of PHP 5.3.0. Relying on this feature is highly discouraged._ |
| [pcre](http://php.net/pcre)             | _Before PHP 5.3.0, this extension could be disabled by passing in the --without-pcre-regex configuration option._ |
| [Reflection](http://php.net/Reflection) | |
| [SPL](http://php.net/SPL)               | |
| standard                                | Core can't have everything, so… standard |

### PHP 5 default but optional modules

**Default modules** can be removed with their respective `--disable-thing` flag. They can all be disabled with `--disable-all` and selectively added with `--enable-thing`

- [ctype](http://php.net/ctype)          
- [dom](http://php.net/dom)              
- [fileinfo](http://php.net/fileinfo)    
- [filter](http://php.net/filter)        
- [hash](http://php.net/hash)            
- [iconv](http://php.net/iconv)          
- [json](http://php.net/json)            
- [libxml](http://php.net/libxml)        
- [PDO](http://php.net/PDO)              
- [pdo_sqlite](http://php.net/pdo_sqlite)
- [Phar](http://php.net/Phar)            
- [posix](http://php.net/posix)          
- [session](http://php.net/session)      
- [sqlite3](http://php.net/sqlite3)      
- [SimpleXML](http://php.net/SimpleXML)  
- [tokenizer](http://php.net/tokenizer)  
- [xml](http://php.net/xml)              
- [xmlreader](http://php.net/xmlreader)  
- [xmlwriter](http://php.net/xmlwriter)  
