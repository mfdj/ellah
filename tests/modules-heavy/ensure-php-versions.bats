#!/usr/bin/env bats

load '../test-helper'

@test 'runs' {
   run_ellah 'modules/ensure-php-versions'
   (( status == 0 ))
}
