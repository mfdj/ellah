#!/usr/bin/env bash

<< 'COMMENT'
   devlopment-only shim to bootstrap and run modules directly.
COMMENT

# shellcheck disable=2155
{
   export ELLAH_ROOT=$(cd "$(dirname "$0")" && pwd -P)
   export LABORATORY=$PWD
}

# shellcheck source=_bootstrap.sh
source "$ELLAH_ROOT/_bootstrap.sh"

run-module "$@"