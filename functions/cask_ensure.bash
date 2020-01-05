#!/bin/bash

cask_ensure() {
   brew cask install $1 2> /dev/null
   [[ $VERBOSE ]] && echo -n " ✔ $1"
}
