#!/usr/bin/env ellah-kit
# shellcheck shell=bash

ensure_path() {
   for path in "$@"; do
      [[ -h $path ]] && rm "$path"
      [[ -f $path ]] && mv "$path"{,-backup}
      [[ -d $path ]] || mkdir -p "$path"
   done
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   ensure_path "${@}"
fi
