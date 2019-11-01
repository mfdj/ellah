#!/bin/bash

prepend_intyversion() {
   awk -F. '{ printf "%03d%03d%03d %s\n", $1, $2, $3, $1"."$2"."$3 }'
}

json_to_php_hash() {
   php -r 'print_r(json_decode(fgets(STDIN), true));'
}

extract_versions() {
   grep '^    \[' | tr -d '][' | awk '{print $1}'
}

get_php_versions() {
   curl -o "./php${1}.json" "https://secure.php.net/releases/index.php?json&version=${1}&max=100"
}

sort_and_exclude_before_min_version() {
   # 5.5.9+
   sort -r | awk '{ if ($1 > 5005008) print $1" "$2 }'
}
