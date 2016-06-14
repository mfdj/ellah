#!/usr/bin/env bats

load '../test-helper'

levelKeyword=(debug info warn error)

@test 'log fails without arguments' {
   run log
   (( status == 1 ))
}

@test 'log fails when single argument is a level-keyword' {
   for level in "$levelKeyword"; do
      run log "$level"
      (( status == 1 ))
   done
}

@test 'log succeeds when level-keyword has a message' {
   for level in "$levelKeyword"; do
      run log "$level" 'For the love of House'
      (( status == 0 ))
   done
}

@test 'log debug outputs as expected' {
   run log debug 'Make BASH great again'
   [[ -z $output ]]

   export VERBOSE=true
   run log debug 'Make BASH great again'
   [[ $output =~ ^(m|M)ake\ BASH\ great\ again ]]
}

@test 'log is debug if no level-keyword provided' {
   run log 'Daydream Nation'
   (( status == 0 ))
   [[ -z $output ]]
}

@test 'log debug writes to stdout when VERBOSE is true' {
   export VERBOSE=true

   run log 'I Chase Rivers'
   (( status == 0 ))
   [[ $output =~ 'I Chase Rivers' ]]

   run log debug 'I Chase Rivers'
   (( status == 0 ))
   [[ $output =~ 'I Chase Rivers' ]]
}

@test 'log handles barewords' {
   export VERBOSE=true

   run log debug Something Good Can Work Remix
   (( status == 0 ))
   [[ $output =~ 'Something Good Can Work Remix' ]]
}
