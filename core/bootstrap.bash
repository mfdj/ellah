#!/bin/bash

for fn in "${ELLAH_ROOT?}"/core/functions/*.bash; do
   # shellcheck disable=SC1090
   source "$fn" || {
      echo "importing core function '$fn' failed" >&2
      return 1
   }
done

# shellcheck source=process-flags.bash
source "$ELLAH_ROOT/core/process-flags.bash" || {
  echo 'process-flags failed' >&2
  return 1
}

log debug "ellah-options
--------------------------------------------------------------------------------
labrotary      : $LABORATORY
verbose        : $VERBOSE
php-version    : $PHP_VERSION
apache-version : $APACHE_VERSION
clean-src      : $CLEAN_SOURCE
clean-build    : $CLEAN_BUILD
skip-gpg       : $SKIP_GPG
*              : $*
"

use 'functions/demand'
log debug "demanding that '$LABORATORY' is a safe laboratory"
demand 'LABORATORY'
mkdir -p "$LABORATORY/environments"
