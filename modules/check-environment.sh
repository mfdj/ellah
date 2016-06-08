#!/usr/bin/env bash

use 'config-helpers'
use 'resolve_semver'

[[ $env_name =~ ^[.0-9a-z\-]*$ ]] || {
   log error "invalid environment-name '$env_name'"
   exit 1
}

log info "using '$env_name' environemnt"

# check path and load configuration
env_path=${LABORATORY}/environemnts/${env_name}
echo $env_path

exit 0

env_config=$env_path/configuration

current_php_version=$(get_config_value php)
parsed_apache_version=$(get_config_value apache)

[[ ! $php_version && $current_php_version ]] && {
   php_version=$current_php_version
}

php_version=$(
   context 'available-versions'

   resolve_semver $php_version ./php-list > /dev/null || {
      log error "could not resolve '$php_version' to valid version in '$(pwd)/php-list'"
      exit 1
   }

   resolve_semver $php_version ./php-list | awk '{print $2}'
)

echo "php_version $php_version"
echo

exit 1

log info "using php '$php_version'"

env_php_path=${env_path}/${php_version}
