# shellcheck disable=SC2148

clean_path() {
   remove_path "$@"
   ensure_path "$@"
}

remove_path() {
   for path in "$@"; do
      [[ -h $path ]] && rm "$path"
      [[ -f $path ]] && rm "$path"
      [[ -d $path ]] && rm -rf "$path"
   done
}

ensure_path() {
   for path in "$@"; do
      [[ -h $path ]] && rm "$path"
      [[ -f $path ]] && mv "$path"{,-backup}
      [[ -d $path ]] || mkdir -p "$path"
   done
}
