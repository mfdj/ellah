
use 'path-helpers'

php_path_symlink() {
   log debug "linking $1"

   # bin
   if [[ -f ${env_php_path}/bin/$1 ]]; then
      ensure_symlink "${env_php_path}"/bin/$1 /usr/local/bin/$1

   # sbin
   elif [[ -f ${env_php_path}/sbin/$1 ]]; then
      ensure_symlink "${env_php_path}"/sbin/$1 /usr/local/bin/$1

   else
      log warn "skipping: $1 wasn't compiled"
   fi
}

php_path_symlink php
php_path_symlink php-fpm
php_path_symlink pecl
php_path_symlink phpize
php_path_symlink pear
php_path_symlink phar

:
