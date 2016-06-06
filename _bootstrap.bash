# shellcheck disable=SC2148

# shellcheck source=_core.bash
source "${ELLAH_ROOT?}/_core.bash" || return 1

# shellcheck source=_process-flags.bash
source "$ELLAH_ROOT/_process-flags.bash" || return 1

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

return 0
