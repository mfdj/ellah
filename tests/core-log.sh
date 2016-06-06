#!/usr/bin/env bats

load 'test_helper'

@test 'log fails without arguments' {
   run log
   (( status == 1 ))
}

@test 'log fails when single argument is a level-keyword' {
   run log debug
   (( status == 1 ))

   run log info
   (( status == 1 ))

   run log warn
   (( status == 1 ))

   run log error
   (( status == 1 ))
}

@test 'log succeeds when level-keyword has a message' {
   run log debug 'For the love of House'
   (( status == 0 ))

   run log info 'For the love of Beats'
   (( status == 0 ))

   run log warn 'For the love of Dance'
   (( status == 0 ))

   run log error 'For the love of House'
   (( status == 0 ))
}

@test 'log debug outputs as expected' {
   run log debug 'Make BASH great again'
   [[ -z $output ]]

   export VERBOSE=true
   run log debug 'Make BASH great again'
   [[ $output =~ ^(m|M)ake\ BASH\ great\ again ]]
}

@test 'log is debug by default' {
   run log 'Preporation Six'
   (( status == 0 ))
   [[ -z $output ]]

   export VERBOSE=true
   run log 'Preporation Six'
   (( status == 0 ))
   [[ $output ]]
}

@test 'log handles barewords' {
   run log 'Something Good Can Work (Remix)'
   (( status == 0 ))
   [[ -z $output ]]

   export VERBOSE=true
   run log 'Something Good Can Work (Remix)'
   (( status == 0 ))
   [[ $output ]]
}
