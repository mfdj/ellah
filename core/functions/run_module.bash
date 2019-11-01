#!/bin/bash

run_module() {
   local module=${1?}
   local status
   shift 1

   log debug "running '$module' with parameters '$*'"

   if ! "${ELLAH_ROOT?}/modules/$module.sh" "$@"; then
      status=$?
      log error "module '$module' run failed with status '$status'"
      exit 1
   fi
}
export -f run_module

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  run_module "${@}"
fi
