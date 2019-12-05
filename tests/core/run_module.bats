#!/usr/bin/env bats

load '../test-helper'

@test 'run_module fails without module paramter (argument 1)' {
   run_ellah 'core/functions/run_module'
   (( status == 1 ))
   [[ $output =~ 1.*parameter.*not\ set ]]
}

@test 'run_module fails on non-existent module' {
   run_ellah 'core/functions/run_module' 'this-is-non-existent'
   (( status == 127 ))
   [[ ${lines[0]} =~ No\ such\ file\ or\ directory ]]
}

@test 'run_module runs "smoke test" module' {
   run_ellah 'core/functions/run_module' 'smoke' 0
   (( status == 0 ))
   [[ ${lines[0]} =~ ^smoke-test$ ]]
}

@test 'run_module fails if the module exits with a non-zero status' {
   run_ellah 'core/functions/run_module' 'smoke' 13
   (( status == 13 ))
}

@test 'run_module passes parameters to the module' {
   run_ellah 'core/functions/run_module' 'smoke' Moroder "Crab Matrix"
   grep 'all-arguments: Moroder Crab Matrix' <<< "$output"
   grep 'argument 1: Moroder$' <<< "$output"
   grep 'argument 2: Crab Matrix$' <<< "$output"
}
