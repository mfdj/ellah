# shellcheck disable=SC2148

ensure_phpdotnet_file() {
   local remote_file=$1
   local local_file=$2
   local silent_flag='--silent'

   [[ $VERBOSE ]] && silent_flag=''

   [[ -f $local_file ]] || {
      curl $silent_flag --location --fail --output "$local_file" "https://php.net/get/${remote_file}/from/this/mirror"

      if [[ -f $local_file ]]; then
         log info "Downloaded '$remote_file'"
      else
         curl $silent_flag --location --head "https://php.net/get/${remote_file}/from/this/mirror" > ensure_phpdotnet_file.log
         log error "Failed to download '$remote_file' see '$PWD/ensure_phpdotnet_file.log'"
      fi
   }
}
