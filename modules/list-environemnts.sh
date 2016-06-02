#!/usr/bin/env bash

log info 'environments'

find "$LABORATORY/environments" -maxdepth 1 -exec basename {} \; \
   | tail -n+2 \
   | awk '{ printf(" ► \x1B[0;32m%s\x1B[0m\n", $0, $1) }'
