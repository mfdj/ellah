#!/usr/bin/env bats

load '../test-helper'

@test 'smoke works directly' {
   run "$ELLAH_ROOT/modules/smoke.sh"
   (( status == 0 ))
}

@test 'smoke works via run_ellah_module' {
   run_ellah_module 'smoke'
   (( status == 0 ))
}
