#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'core/functions/log'

exit_status=${1:-13}

echo 'smoke-test'
echo "all-arguments: $*"
position=1
while (( $# > 0 )); do
   echo " • argument $position: $1"
   shift
   ((position++))
done

log debug some debug
log info some info

echo "ELLAH_ROOT: '$ELLAH_ROOT'"
echo "LABORATORY: '$LABORATORY'"
tree "$ELLAH_ROOT" "$LABORATORY" -d -L 2

exit $exit_status
