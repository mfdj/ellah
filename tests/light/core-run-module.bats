#!/usr/bin/env bats

load '../test_helper'

@test 'run-module without argument fails' {
  run run-module
  (( status == 1 ))
  [[ $output =~ 'parameter null or not set' ]]
}

@test 'run-module smoke works' {
  run run-module smoke
  (( status == 0 ))
}

@test 'run-module non-existent module fails' {
  run run-module blow-up
  (( status == 1 ))
  [[ $output ]]
}
