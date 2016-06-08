#!/usr/bin/env bats

load 'test_helper'

@test 'run_module without argument fails' {
  run run_module
  (( status == 1 ))
  [[ $output =~ 'parameter null or not set' ]]
}

@test 'run_module smoke works' {
  run run_module smoke
  (( status == 0 ))
}

@test 'run_module blow-up fails' {
  run run_module blow-up
  (( status == 1 ))
  [[ $output ]]
}
