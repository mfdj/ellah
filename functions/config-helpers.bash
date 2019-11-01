#!/bin/bash

config_get() {
   grep "^$1: " "$ENV_CONFIG" | awk '{print $2}'
}

config_set() {
   if grep "^$1: " "$ENV_CONFIG"; then
      sed -ie "s/$1: .*/$1: $2/" "$ENV_CONFIG"
   else
      echo "$1: $2" >> "$ENV_CONFIG"
   fi
}
