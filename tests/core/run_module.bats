#!/usr/bin/env bats

load '../test-helper'

@test 'run_module fails when $ELLAH_ROOT is not set' {
   unset ELLAH_ROOT
   run run_module 'punkrock'
   (( status == 1 ))
   [[ $output =~ 'parameter null or not set' ]]
}

@test 'run_module fails without module paramter (argument 1)' {
   run run_module
   (( status == 1 ))
   [[ $output =~ 'parameter null or not set' ]]
}

@test 'run_module fails on non-existent module' {
   run run_module 'this-is-non-existent'
   (( status == 1 ))
   [[ $output =~ module.+this-is-non-existent.+run\ failed ]]
}

@test 'run_module will work but will emit a warning when log function is not set' {
   unset log
   run run_module 'smoke'
   (( status == 0 ))
   [[ $output =~ 'log: command not found' ]]
}

@test 'run_module runs "smoke test" module' {
   run run_module 'smoke'
   (( status == 0 ))
}

@test 'run_module fails if the module exits with a non-zero status' {
   run run_module 'exit-one'
   (( status == 1 ))
}

@test 'run_module passes parameters to the module' {
   run run_module 'smoke' Moroder "Crab Matrix"
   grep 'all-arguments: Moroder Crab Matrix' <<< "$output"
   grep '^argument 1: Moroder$' <<< "$output"
   grep '^argument 2: Crab Matrix$' <<< "$output"
}
