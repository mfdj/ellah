#!/usr/bin/env ellah-kit
# shellcheck shell=bash

log() {
   "${ELLAH_ROOT:?}/deps/colored-logger/colored-logger.bash" "$@"
}
export -f log

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  log "${@}"
fi
