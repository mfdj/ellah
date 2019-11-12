#!/usr/bin/env bats

load '../test-helper'

levelKeywords=(debug info warn error)

@test 'log warns without arguments' {
   run log
   (( status == 0 ))
   (( ${#lines[@]} == 1 ))
   grep '^log: expecting at least one argument$' <<< "$output"
}

@test 'log warns when single argument is a level-keyword' {
   for level in "${levelKeywords[@]}"; do
      run log "$level"
      (( status == 0 ))
      (( ${#lines[@]} == 1 ))
      grep '^log: expecting a message$' <<< "${lines[0]}"
   done
}

@test 'log writes a message to stdout for non-debug messages' {
   for level in "${levelKeywords[@]}"; do
      [[ $level = 'debug' ]] && continue

      run log "$level" 'For the love of House'
      (( status == 0 ))
      grep 'For the love of House' <<< "${lines[0]}"
   done
}

@test 'log debug is default level and is silent by default' {
   run log 'I Chase Rivers'
   (( status == 0 ))
   [[ -z $output ]]

   run log debug 'I Chase Rivers'
   [[ -z $output ]]
}

@test 'log debug outputs when VERBOSE is true' {
   export VERBOSE=true

   run log 'I Chase Rivers'
   (( status == 0 ))
   [[ $output =~ 'I Chase Rivers' ]]

   run log debug 'I Chase Rivers'
   [[ $output =~ 'I Chase Rivers' ]]
}

@test 'log handles barewords' {
   for level in "${levelKeywords[@]}"; do
      VERBOSE=true
      run log "$level" Something Good Can Work Remix
      (( status == 0 ))
      [[ $output =~ 'Something Good Can Work Remix' ]]
   done
}
