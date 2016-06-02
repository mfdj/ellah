
- [Requirements for Running Symfony](http://symfony.com/doc/current/reference/requirements.html)
- [Magento2 system requirements](http://devdocs.magento.com/guides/v2.0/install-gde/system-requirements.html)
- [Laravel system requirements](http://laravel.com/docs/5.2#installation)
- [Drupal 8 required extensions](https://www.drupal.org/requirements/php#extensions)

**Enabled with default php configure**

| extension                               | --enable-…   | symfony2  | magento2 | laravel5 | drupal8 |
| ---                                     | ---          | ---       | ---      | ---      | ---     |
| [ctype](http://php.net/ctype)           | `ctype`      | ✓         |          |          |         |
| [dom](http://php.net/dom)               | `dom` + `libxml`     |   |          |          |         |
| [fileinfo](http://php.net/fileinfo)     | `fileinfo`   |           |          |          |         |
| [filter](http://php.net/filter)         | `filter`     |           |          |          |         |
| [hash](http://php.net/hash)             | `hash`       |           |          |          |         |
| [iconv](http://php.net/iconv)           | `iconv`      | optional  |          |          |         |
| [json](http://php.net/json)             | `json`       | ✓         |          |          |         |
| [libxml](http://php.net/libxml)         | `libxml`     |           |          |          |         |
| [PDO](http://php.net/PDO)               | `PDO`        |           |          |          |         |
| [pdo_sqlite](http://php.net/pdo_sqlite) | `pdo_sqlite` |           |          |          |         |
| [Phar](http://php.net/Phar)             | `Phar`       |           |          |          |         |
| [posix](http://php.net/posix)           | `posix`      |           |          |          |         |
| [session](http://php.net/session)       | `session`    |           |          |          |         |
| [sqlite3](http://php.net/sqlite3)       | `sqlite3`    |           |          |          |         |
| [SimpleXML](http://php.net/SimpleXML)   | `simplexml` + `libxml` |  |         |          |         |
| [tokenizer](http://php.net/tokenizer)   | `tokenizer`  | optional  |          |          |         |
| [xml](http://php.net/xml)               | `xml` + `libxml` | optional |       |          |         |
| [xmlreader](http://php.net/xmlreader)   | `xmlreader` + `libxml` | |          |          |         |
| [xmlwriter](http://php.net/xmlwriter)   | `xmlwriter` + `libxml` | |          |          |         |

**Non-enabled with default php configure**

| extension                               | --enable-…   | symfony2  | magento2 | laravel5 | drupal8 |
| ---                                     | ---          | ---       | ---      | ---      | ---     |
| [mbstring](http://php.net/mbstring)     | `mbstring `  | ✓         |          |          |         |

### Composer

Requires: json, phar, filter, hash, openssl

```
Some settings on your machine make Composer unable to work properly.
Make sure that you fix the issues listed below and run this script again:

The json extension is missing.
Install it or recompile php without --disable-json

The phar extension is missing.
Install it or recompile php without --disable-phar

The filter extension is missing.
Install it or recompile php without --disable-filter

The hash extension is missing.
Install it or recompile php without --disable-hash

The openssl extension is missing, which means that secure HTTPS transfers are impossible.
If possible you should enable it or recompile php with --with-openssl
```
