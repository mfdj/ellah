#!/bin/bash

# Minimum version 5.5.9+
clean_min_version() {
   sort -r | awk '{ if ($1 > 5005008) print $1" "$2 }'
}
export -f clean_min_version

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   clean_min_version "${@}"
fi
