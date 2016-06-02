
Cribbed from: https://github.com/Homebrew/homebrew-php/blob/master/Contributions/Using%20FPM.md

**install apache 2.4**

```
brew install homebrew/apache/httpd24
```

**install mod_fastcgi**

```
brew install mod_fastcgi --with-homebrew-httpd24
```

the post-install backtrace will show the needed apache directive but so will

```
brew info mod_fastcgi
``` 

add the directive (like)

```
LoadModule fastcgi_module /usr/local/Cellar/mod_fastcgi/2.4.6/libexec/mod_fastcgi.so
```

to httpd.conf

```
$EDITOR /usr/local/etc/apache2/2.4/httpd.conf
```

**actions_module**

also uncomment `actions_module` (needed for using `Action php-fastcgi /php-fpm`)

```
LoadModule actions_module libexec/mod_actions.so
```

**tip: confrim and verify apache module configs** 

```
apachectl -t -D DUMP_MODULES1
```

**instal php-fpm**

configure php with `--enable-fpm`

**setup php-fpm config**

copy the default pool-conf 

```
cp ~/.ellah-laboratory/environments/default/7.0.6/etc/php-fpm.d/www.conf{.default,}
```

now `~/.ellah-laboratory/environments/default/7.0.6/etc/php-fpm.d/www.conf` exists

find the fpm-conf 

```
find ~/.ellah-laboratory -iname '*fpm*conf'
```

e.g. `~/.ellah-laboratory/…/sapi/fpm/php-fpm.conf`

Note: don't literally use `~`

Use unix socket (instead of TCP) add 

```
listen = /tmp/php-fpm.sock
```

Note: this [ServerFault question](http://serverfault.com/questions/646245/php-fpm-not-working-on-apache2-failed-to-connect-to-fastcgi-server) helped me realize I was using TCP (the php-fpm default) 

**run php-fpm**

```
php-fpm
````

**add fpm conf to virtualhost**

```
<VirtualHost *:8080>
    ServerName < project-url >
    DocumentRoot "~/projects/< project-name >"
    ErrorLog "/usr/local/var/log/apache2/< project-url >-error_log"
    CustomLog "/usr/local/var/log/apache2/< project-url >-access_log" common

    <Directory "~/projects/< project-name >">
      Options Indexes MultiViews
      DirectoryIndex index.php
      AllowOverride All
      Require all granted
    </Directory>

    # Ensure that mod_php5 is off
    <IfModule mod_php5.c>
      php_admin_flag engine off
    </IfModule>

    <IfModule mod_fastcgi.c>
      AddHandler php-fastcgi .php
      Action php-fastcgi /php-fpm
      Alias /php-fpm /usr/local/var/www/htdocs/fpm.fcgi
      
      # If PHP-FPM is configured to listen on a Unix socket, use this:
      FastCGIExternalServer /usr/local/var/www/htdocs/fpm.fcgi -socket /tmp/php-fpm.sock
      
      # Otherwise, use this:
      #FastCGIExternalServer /usr/local/var/www/htdocs/fpm.fcgi -host 127.0.0.1:9000

      # Without the following directive, you'll get an Access Forbidden error
      # when the path aliased by /php-fpm is not under the document root:
      <Location /php-fpm>
          Order Deny,Allow
          Deny from all
          Allow from env=REDIRECT_STATUS
      </Location>
    </IfModule>
</VirtualHost>
```
