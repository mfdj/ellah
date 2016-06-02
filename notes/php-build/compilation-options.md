Starting from [php.net/manual/en/install.unix.php](http://php.net/manual/en/install.unix.php).

Notably

- [unix.nginx.php](http://php.net/manual/en/install.unix.nginx.php)
  - which details the most modern approach of using PHP-FPM
- [unix.apache2.php](http://php.net/manual/en/install.unix.apache2.php)
  - which details how to install php as a Multi-Processing Module (i.e. php-mod).
  - [prefork](https://httpd.apache.org/docs/2.2/mod/prefork.html) is a non-threaded, pre-forking web server. Essentialy a [fork](https://en.wikipedia.org/wiki/Fork_(system_call)) is a copy of a unix-process. A pre-fork webserver means a ["master process creates forks which handle each request. A fork is a completely separate *nix process."](http://stackoverflow.com/questions/25834333/what-exactly-is-a-pre-fork-web-server-model)
  - Apache also supports using MPMs as [worker](https://httpd.apache.org/docs/2.2/mod/worker.html) or [event](https://httpd.apache.org/docs/2.2/mod/event.html) and are not recommended for use with mod-php since they are not thread-safe and most php extensions aren't either
- [unix.debian.php](http://php.net/manual/en/install.unix.debian.php)

[wiki.apache.org/httpd/php-fastcgi](http://wiki.apache.org/httpd/php-fastcgi)

> mod\_php in most cases is not a viable solution, since it introduces scalability issues with the added RAM requirement for each httpd process. Additionally, it precludes the use of threaded MPMs since php extensions are not thread-safe in many cases.

[wiki.apache.org/httpd/php-fcgid](http://wiki.apache.org/httpd/php-fcgid)

> Why run PHP with fcgid?
>
> - mod\_php forces you to load prefork MPM, which is inefficient.
> - mod\_php will be loaded into httpd's memory even when serving static pages
> - most distributions shipping in 2013 provide precompiled packages that let you run php with fcgid. This is just a matter of configuration. mod\_fcgid is an official Apache module

[wiki.apache.org/httpd/PHP-FPM](http://wiki.apache.org/httpd/PHP-FPM)

>  the ability to run PHP as a fastCGI process server, and address that fastCGI server directly from within apache, via a dedicated proxy module (mod\_proxy\_fcgi.)

[linode.com/…/running-fastcgi-php-fpm-on-debian-7-with-apache](https://www.linode.com/docs/websites/apache/running-fastcgi-php-fpm-on-debian-7-with-apache)

> PHP-FPM brings in the concept of pools. Using pools you can control the amount of resources dedicated to each virtual host, and also run PHP scripts as different users
