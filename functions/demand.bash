# shellcheck disable=SC2148

demand() {
   local varname=${1?}

   [[ -z ${!varname} ]] && {
      log error "'$varname' variable is empty"
      exit 1
   }
}
