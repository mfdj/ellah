#!/usr/bin/env bash

echo 'smoke-test'
echo "all-arguments: $*"
position=1
while (( $# > 0 )); do
   echo " • argument $position: $1"
   shift
   ((position++))
done
echo "ELLAH_ROOT: '$ELLAH_ROOT'"
echo "LABORATORY: '$LABORATORY'"
log debug some debug info
echo "ls:"
ls -la
