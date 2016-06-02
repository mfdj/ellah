# shellcheck disable=SC2148

resolve_semver() {
   local version_pattern
   local version_list=$2

   [[ $1 =~ ^[0-9]+$                 ]] && version_pattern="(^| )${1}\.[0-9]*\.[0-9]*( |$)"
   [[ $1 =~ ^[0-9]+\.[0-9]+$         ]] && version_pattern="(^| )${1}\.[0-9]*( |$)"
   [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] && version_pattern="(^| )${1}( |$)"

   if ! egrep "$version_pattern" "$version_list" > /dev/null; then
      return 1
   fi

   egrep "$version_pattern" "$version_list" | head -n 1
}
