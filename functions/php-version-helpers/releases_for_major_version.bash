#!/bin/bash

releases_for_major_version() {
   curl --silent --location --fail --output "./${2}" \
      "https://secure.php.net/releases/index.php?json&version=${1}&max=100"
}
export -f releases_for_major_version

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
   releases_for_major_version "${@}"
fi
