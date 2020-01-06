#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'core/functions/log'
use 'functions/demand'
use 'functions/ensure_symlink'

path_to_php=$1
link_to=$2

demand 'path_to_php'
demand 'link_to'

link_bin() {
   log debug "linking $1"

   # bin
   if [[ -f ${path_to_php}/bin/$1 ]]; then
      ensure_symlink "${path_to_php}/bin/${1}" "$link_to/$1"

   # sbin
   elif [[ -f ${path_to_php}/sbin/$1 ]]; then
      ensure_symlink "${path_to_php}/sbin/${1}" "$link_to/$1"

   else
      log warn "skipping: $1 wasn't compiled"
   fi
}

link_bin php
link_bin php-fpm
link_bin pecl
link_bin phpize
link_bin pear
link_bin phar
