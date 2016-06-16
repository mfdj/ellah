#!/usr/bin/env bats

# NOTE: if test-helper is not used then custom commands like 'run_module' will cause the test to
# exit with a status of (int) 127 which is a special BASH "command not found" status
load '../test-helper'

@test 'core-dependencies smoke test' {
  run run_module 'core-dependencies'
  (( status == 0 ))
}
