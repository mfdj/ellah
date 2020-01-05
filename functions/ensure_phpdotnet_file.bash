#!/bin/bash

ensure_phpdotnet_file() {
   local remote_file=$1
   local local_file=$2
   local url="https://www.php.net/get/${remote_file}/from/this/mirror"

   [[ -f $local_file ]] || {
      curl --silent --location --fail --output "$local_file" "$url"

      if [[ -f $local_file ]]; then
         log info "Downloaded '$remote_file'"
      else
         echo "### $url" >> ensure_phpdotnet_file.log
         curl --silent --location --head "$url" >> ensure_phpdotnet_file.log
         log error "Failed to download '$remote_file'"
         log " • see '$PWD/ensure_phpdotnet_file.log'"
      fi
   }
}
