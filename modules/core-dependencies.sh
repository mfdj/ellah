#!/usr/bin/env ellah-kit
# shellcheck shell=bash

use 'functions/brew_ensure'
use 'core/functions/log'

command -v xcode-select > /dev/null && {
   xcode-select --install 2> /dev/null || {
      log debug " ✔ xcode-select"
   }
}

! command -v brew > /dev/null && {
   log warn 'Please install homebrew from http://brew.sh'
   log info "'open http://brew.sh'" # copied to clipboard (paste to execute)
   # echo 'open http://brew.sh' | pbcopy
   exit 1
}

log debug " ✔ homebrew"

brew_ensure autoconf     &&
brew_ensure libiconv     &&
brew_ensure make         &&
brew_ensure md5sha1sum   &&
brew_ensure gnupg2       || exit 1

# NOTE: make is GNU make, linked as gmake

[[ $VERBOSE ]] && echo || true # visual line-break

exit 0
