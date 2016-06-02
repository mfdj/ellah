#/usr/bin/env bash

require 'php-version-helpers'
require 'time-helpers'

update_php_versions() {
   log info 'updating available php-versions'

   get_php_versions 5
   get_php_versions 7

   (  cat ./php5.json | json_to_php_hash | extract_versions
      cat ./php7.json | json_to_php_hash | extract_versions
   ) | prepend_intyversion | sort_and_exclude_before_min_version > ./php-list
}

context 'available-versions'

[[ -f ./php-list ]] || update_php_versions

[[ $(since_last_modified ./php-list days) > 1 ]] && update_php_versions

exit 0
