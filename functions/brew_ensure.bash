# shellcheck disable=SC2148

brew_ensure() {
   BREW_PREFIX=${BREW_PREFIX:-`brew --prefix`} # will be set once per script session
   local package=$1

   if ! ls -l1 "$BREW_PREFIX/opt/" | grep -q "^$1$"; then
      (( $# != 1 )) && shift
      if [[ $VERBOSE ]]; then
         brew install "$@" || return 1
      else
         brew install "$@" > /dev/null || return 1
      fi
   elif [[ $VERBOSE ]]; then
      echo -n " ✔ $package"
   fi

   return 0
}
