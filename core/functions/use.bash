# shellcheck disable=SC2148

use() {
   log debug "using '$1'"

   # shellcheck disable=SC1090
   if ! source "${ELLAH_ROOT?}/${1?}.bash"; then
      log error "using '$1' failed"
      exit 1
   fi

   return 0
}

export -f use
