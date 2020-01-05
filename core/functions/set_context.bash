#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'core/functions/log'

set_context() {
   local context=${LABORATORY:?}/${1:?}

   log debug "setting context to '$1' ($context)"

   [[ -d $context ]] || {
      [[ -h $context ]] && rm "$context"
      [[ -f $context ]] && mv "$context"{,-backup}
      mkdir -p "$context"
   }

   cd -P "$context" || {
      log error "failed to set_context to '$1'"
      exit 1
   }
}
export -f set_context

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   set_context "${@}"
fi
