#!/bin/bash

index=1
while [[ $index -le $# ]]; do
   param=${!index}
   if [[ $param != -* ]]; then ((index++)) # not a parameter flag so advance index
   else
      ((next_index = index + 1))
      word_count=1

      case $param in
         # paramter-flags with arguments
         --apache=*) APACHE_VERSION=${param#*=};;
         -a)         APACHE_VERSION=${!next_index}; ((word_count++));;

         --php=*)    PHP_VERSION=${param#*=};;
         -p)         PHP_VERSION=${!next_index}; ((word_count++));;

         # binary flags
         --clean-src)   CLEAN_SOURCE=true; CLEAN_BUILD=true;;
         --clean-build) CLEAN_BUILD=true;;
         # --clean-all)   …;; # if more clean options come along
         --skip-gpg)    SKIP_GPG=true;;
         -v|--verbose)  VERBOSE=true;;
      esac

      # remove word_count out of positional list starting at index
      (( $index > 1  )) && set -- "${@:1:((index - 1))}" "${@:((index + word_count)):$#}"
      (( $index == 1 )) && set -- "${@:((index + word_count)):$#}"
   fi
done

export APACHE_VERSION
export PHP_VERSION
export CLEAN_SOURCE
export CLEAN_BUILD
export SKIP_GPG
export VERBOSE

return 0
