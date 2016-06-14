#!/usr/bin/env bats

@test 'run-module without argument fails' {
  run run-module 'core-dependencies'
  (( status == 0 ))
}
