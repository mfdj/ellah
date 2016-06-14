#!/usr/bin/env bats

load '../test-helper'

@test 'run_module fails without module paramter (argument 1)' {
  run run_module
  (( status == 1 ))
  [[ $output =~ 'parameter null or not set' ]]
}

@test 'run_module runs "smoke test" module' {
  run run_module 'smoke'
  (( status == 0 ))
}

@test 'run_module non-existent module fails' {
  run run_module 'this-is-non-existent'
  (( status == 1 ))
  [[ $output ]]
}
