#!/bin/bash

prepend_intyversion() {
   awk -F. '{ printf "%03d%03d%03d %s\n", $1, $2, $3, $1"."$2"."$3 }'
}
export -f prepend_intyversion

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   prepend_intyversion "${@}"
fi
