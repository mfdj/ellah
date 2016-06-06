# shellcheck disable=SC2148

set-context() {
   local lab_dir="${LABORATORY}/${1}"

   log debug "setting context to '$1' ($lab_dir)"

   [[ -d $lab_dir ]] || {
      [[ -h $lab_dir ]] && rm "$lab_dir"
      [[ -f $lab_dir ]] && mv "$lab_dir"{,-backup}
      mkdir -p "$lab_dir"
   }

   cd -P "$lab_dir" || {
      log error "failed to set-context to '$1'"
      exit 1
   }
}

log() {
   local level
   local color
   local color_off='\x1B[0m'
   local context="(${0##*/})"
   local grey='\x1B[0;37m'

   case $1 in
      debug) level=0;;
       info) level=1; context='';;
       warn) level=2;;
      error) level=3;;
   esac

   [[ $level ]] && shift || level=0

   case $level in
      0) color_off=;;
      1) color='\x1B[0;32m';; # Green
      2) color='\x1B[0;33m';; # Yellow
      3) color='\x1B[0;31m';; # Red
   esac

   [[ $VERBOSE || $level -gt 0 ]] && echo -e "${color}${*}${color_off} ${grey}${context}${color_off}"

   # [[ $ellah_logfile ]] && echo "$@" >> "$ellah_logfile"
}

note() {
   : # no-op
}

use() {
   log debug "requiring '$1'"

   # shellcheck disable=SC1090
   if ! source "${ELLAH_ROOT}/${1}.bash"; then
      log error "require '$1' failed"
      exit 1
   fi
}

run-module() {
   local module=$1
   shift 1

   log debug "running '$module' with '$*'"

   if ! "$ELLAH_ROOT/modules/$module.sh" "$@"; then
      log error "module '$module' run failed"
      exit 1
   fi
}

export -f note        && \
export -f run-module  && \
export -f log         && \
export -f set-context && \
export -f use         || exit 1
