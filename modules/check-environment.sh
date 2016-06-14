#!/usr/bin/env bash

use 'functions/config-helpers'
use 'functions/resolve_semver'

envName=$1
envPath=${LABORATORY}/environemnts/${envName}
envConfig=$envPath/configuration

# [[ $envName =~ ^[.0-9a-z\-]*$ ]] || {
#    log error "invalid environment-name '$envName'"
#    exit 1
# }

log info "using '$envName' environemnt"

# check path and load configuration

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

env_php_path=${envPath}/${php_version}
