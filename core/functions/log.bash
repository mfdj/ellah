#!/bin/bash

log() {
   local level
   local color
   local color_off='\x1B[0m'
   local context="(${0##*/})"
   local grey='\x1B[0;37m'

   (( $# == 0 )) && {
      echo 'log: expecting at least one argument' >&2
      return
   }

   case $1 in
      debug) level=0;;
       info) level=1;;
       warn) level=2;;
      error) level=3;;
   esac

   [[ -z $VERBOSE ]] && context=''

   [[ $level ]] && shift || level=0

   [[ $# -gt 0 ]] || {
      echo 'log: expecting a message' >&2
      return
   }

   case $level in
      0) color_off=;;
      1) color='\x1B[0;32m';; # Green
      2) color='\x1B[0;33m';; # Yellow
      3) color='\x1B[0;31m';; # Red
   esac

   [[ $VERBOSE || $level -gt 0 ]] &&
      echo -e "${color}${*?}${color_off} ${grey}${context}${color_off}"

   return 0
}
export -f log

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  log "${@}"
fi
