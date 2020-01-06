#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'functions/path-helpers/ensure_path'
use 'functions/path-helpers/remove_path'

clean_path() {
   remove_path "$@"
   ensure_path "$@"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   clean_path "${@}"
fi
