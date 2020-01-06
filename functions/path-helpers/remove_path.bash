#!/usr/bin/env ellah-kit
# shellcheck shell=bash

remove_path() {
   for path in "$@"; do
      [[ -h $path ]] && rm "$path"
      [[ -f $path ]] && rm "$path"
      [[ -d $path ]] && rm -rf "$path"
   done
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   remove_path "${@}"
fi
