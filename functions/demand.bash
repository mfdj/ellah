#!/bin/bash

demand() {
   local varname=${1?}

   [[ -z ${!varname} ]] && {
      log error "'$varname' variable is empty"
      exit 1
   }

   return 0
}
