#!/usr/bin/env bats

load 'test_helper'

@test 'skipped ensure-php-src' {
  run run-module smoke
  (( status == 0 ))
}
