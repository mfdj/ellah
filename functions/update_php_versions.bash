#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'core/functions/log'
use 'functions/php-version-helpers/prepend_intyversion'
use 'functions/php-version-helpers/releases_for_major_version'
use 'functions/php-version-helpers/clean_min_version'
use 'functions/php-version-helpers/extract_versions'

update_php_versions() {
   log info 'Updating known php-versions'

   releases_for_major_version 5 php5.json
   releases_for_major_version 7 php7.json

   { extract_versions php5.json
     extract_versions php7.json
   } | prepend_intyversion | clean_min_version > ./php-versions
}
export -f update_php_versions

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   update_php_versions "${@}"
fi
