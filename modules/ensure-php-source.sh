#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'core/functions/log'
use 'core/functions/set_context'
use 'functions/demand'
use 'functions/ensure_phpdotnet_file'

demand 'PHP_VERSION'

set_context "source-cache/php${PHP_VERSION}"

log debug "Ensuring php ${PHP_VERSION} source and fingerprint"

[[ $CLEAN_SOURCE ]] && rm -f ./* # --force won't emit an error if the directory is empty

ensure_phpdotnet_file "php-${PHP_VERSION}.tar.gz"     'archive.tar.gz'
ensure_phpdotnet_file "php-${PHP_VERSION}.tar.gz.asc" 'signing-key.asc'

[[ -f archive.tar.gz ]] && [[ -f signing-key.asc ]] || {
   log error "Could not ensure php ${PHP_VERSION} source and fingerprint"
   exit 1
}

exit 0
