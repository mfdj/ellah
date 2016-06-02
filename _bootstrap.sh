# shellcheck disable=SC2148

# shellcheck source=_core.sh
source "$ELLAH_ROOT/_core.sh" || exit 1

# shellcheck source=_process-flags.sh
source "$ELLAH_ROOT/_process-flags.sh" || exit 1

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
note "demanding that '$LABORATORY' is a safe laboratory"
demand 'LABORATORY'
