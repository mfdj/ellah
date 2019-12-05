#!/usr/bin/env bats

load '../test-helper'

@test 'smoke works directly' {
   run "$ELLAH_ROOT/modules/smoke.sh"
   (( status == 13 ))
}

@test 'smoke works via run_ellah' {
   run_ellah 'modules/smoke'
   (( status == 13 ))
}
