#!/bin/bash

extract_versions() {
   jq '. | keys[]' --raw-output < "$1"
}
export -f extract_versions

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   extract_versions "${@}"
fi
