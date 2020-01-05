#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'core/functions/log' # NOTE: while conceptually correct core/functions/set_context actually overwrites by importing (the same) log
use 'core/functions/set_context'
use 'functions/time-helpers'
use 'functions/update_php_versions'

log 'Ensuring php-versions exist'
set_context 'available-versions'

if ! [[ -f ./php-versions ]]; then
   log 'Creating php-versions'
   update_php_versions
elif (( $(since_last_modified ./php-versions days) > 1 )); then
   log 'Updating php-versions'
   update_php_versions
else
   log 'php-versions exists'
fi
