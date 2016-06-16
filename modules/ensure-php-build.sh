#!/usr/bin/env bash

# NOTES
# • retrieve php-source
# • compile configuration options
# •

phpsource=$(
   set_context 'source-cache'
   [[ -d php${PHP_VERSION?} ]]
   echo $PWD/php${PHP_VERSION}
) || {
   log error 'could not resolve php-source'
}

echo "phpsource: $phpsource"
exit 0

phpsource=${LABORATORY?}/source-cache/php${PHP_VERSION?}

log info "Building $php_version from $phpsource"

clean_path "$env_php_path"

if [[ $SKIP_GPG ]]; then
   log debug 'skipping gpg verify'
else
   log debug 'verifying archive'
   gpg2 --verify "$phpsource/signing-key.asc" "$phpsource/archive.tar.gz" || {
      log error "could not verify '$phpsource/archive.tar.gz' with '$phpsource/signing-key.asc"
      return 1
   }
fi

log debug "Decompressing php-source in '$env_path/.tmp'"
(
   ensure_path "$env_path/.tmp"
   cd "$env_path/.tmp"
   rm -rf php-*
   tar xf "${phpsource}/archive.tar.gz"
   mv php-*/* "$env_php_path"/
   rm -rf php-*
)

cleanup_php_build() {
   log info "Cleanup PHP Build"
   brew unlink libxml2
   # NOTE: see above
   # brew unlink openssl
}

brew_ensure curl curl --with-openssl
brew_ensure mysql
brew_ensure gd        # installs freetype, jpeg, libpng
brew_ensure icu4c     # for intl
brew_ensure libxml2   # for… numerouse?
brew_ensure mcrypt    # for mcrypt
brew_ensure openssl   # for openssl
brew_ensure readline  # for libedit
brew_ensure zlib      # for zlib/zip
cask_ensure xquartz   # for gd which depends on X11/xmp.h etc.

curl_source=$(brew_cellar_src curl)
icu_source=$(brew_cellar_src icu4c)
openssl_source=$(brew_cellar_src openssl)
libxml_source=$(brew_cellar_src libxml2)
mcrypt_source=$(brew_cellar_src mcrypt)
jpeg_source=$(brew_cellar_src jpeg)

log debug "curl_source    : $curl_source
gd_source      : $gd_source
icu_source     : $icu_source
libxml_source  : $libxml_source
mcrypt_source  : $mcrypt_source
openssl_source : $openssl_source"

brew link libxml2 --force
# NOTE: had to do this on test-machine?
# NOTE: each config option should get its own prep/cleanup file, they can be cat'd and uniq'd
# brew link openssl --force

# standard modules
# • date
# • ereg
# • pcre
# • Reflection
# • SPL
# optional default modules
# • ctype
# • dom
# • fileinfo
# • filter
# • hash
# • iconv
# • json
# • libxml
# • PDO
# • pdo_sqlite
# • Phar
# • posix
# • session
# • simplexml
# • sqlite3
# • tokenizer
# • xml
# • xmlreader
# • xmlwriter

log info "Configuring $env_php_path"

(
   cd "$env_php_path"

   ./configure \
      --prefix=${env_php_path} \
      --disable-cgi \
      --disable-short-tags \
      --with-curl=${curl_source} \
      --with-gd \
      --with-jpeg-dir=${jpeg_source} \
      --with-icu-dir=${icu_source} \
      --with-libxml-dir=${libxml_source} \
      --with-libedit \
      --with-mcrypt=${mcrypt_source} \
      --with-openssl=${openssl_source} \
      --with-pdo-mysql \
      --with-pear \
      --with-xsl \
      --with-zlib \
      --enable-fpm \
      --enable-bcmath \
      --enable-exif \
      --enable-intl \
      --enable-mbregex \
      --enable-mbstring \
      --enable-opcache \
      --enable-pcntl \
      --enable-zip

   # --with-freetype-dir=${freetype_source} \
   # --with-jpeg-dir=${jpeg_source} \
   # --with-png-dir=${libpng_source} \

   # --with-readline had problem on my system; --with-libedit is an alternative that seems to work

   # --with-apxs2=${apache_build_path}/bin/apxs \
   # --with-config-file-path=${env_php_path} \

   [[ $? == 0 ]] || {
      log error "Configuring failed"
      cleanup_php_build
      return 1
   }

   log debug "gmake -j $(sysctl -n hw.ncpu)"
   gmake -j $(sysctl -n hw.ncpu) || {
      log error 'gmake failed'
      cleanup_php_build
      return 1
   }

   gmake install || {
      log error 'gmake install failed'
      cleanup_php_build
      return 1
   }

   cp etc/php-fpm.d/www.conf{.default,}
)

extension_dir=$("$env_php_path/bin/php" -n -i | grep ^extension_dir | sed s/'.* => '/''/)
ensure_path $extension_dir

# build pcntl extension
# if [[ ! -f $extension_dir/pcntl.so && ((php_version[0] != 7)) ]]; then
#   cd ext/pcntl/ \
#     && phpize \
#     && ./configure \
#     && make \
#     && cp modules/pcntl.so $extension_dir
#   cd -
# fi

# if [[ ! -f $extension_dir/mcrypt.so ]]; then
#   cd "$env_php_path/ext/mcrypt/" \
#     && phpize \
#     && ./configure \
#          --prefix=${env_php_path} \
#          --with-mcrypt=${mcrypt_source} \
#          --with-php-config=${env_php_path}/bin/php-config \
#     && make \
#     && cp modules/mcrypt.so $extension_dir
#   cd -
# fi

# pear channel-discover pear.twig-project.org && pear install twig/CTwig
# brew_ensure redis && pecl install redis
# brew_ensure mongodb && pecl install mongodb
# brew_ensure rabbitmq-c
# for file in $(brew ls rabbitmq-c | grep include); do ln -s $file /usr/local/include 2> /dev/null; done
# pecl install amqp
# brew_ensure libsodium && pecl install libsodium

cleanup_php_build

:
