#!/bin/bash

demand() {
   local varname=${1?}

   if [[ -z ${!varname} ]]; then
      log error "'$varname' variable is empty"
      exit 1
   fi
}
