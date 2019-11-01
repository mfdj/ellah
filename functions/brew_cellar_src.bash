#!/bin/bash

brew_cellar_src() {
   BREW_PREFIX=${BREW_PREFIX:-`brew --prefix`}

   find "${BREW_PREFIX}/Cellar/$1" -d 1 | tail -1
}
