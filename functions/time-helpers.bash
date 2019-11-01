#!/bin/bash

since_last_modified() {
   local modified
   local now
   local period

   now=$(date +%s)
   stat -f %m $1 > /dev/null 2>&1 && modified=$(stat -f %m $1) # BSD stat
   stat -c %Y $1 > /dev/null 2>&1 && modified=$(stat -c %Y $1) # GNU stat

   case $2 in
        day|days)    period=86400 ;; # 1 day in seconds
       hour|hours)   period=1440  ;; # 1 hour in seconds
     minute|minutes) period=60    ;; # 1 minute in seconds
           *)        period=      ;;
   esac

   if (( $period > 0 )); then
      echo "$(( (now - modified) / period ))"
   else
      echo "$(( now - modified ))"
   fi
}
