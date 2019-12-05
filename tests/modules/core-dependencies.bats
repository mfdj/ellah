#!/usr/bin/env bats

load '../test-helper'

@test 'core-dependencies runs if brew' {
   run command -v brew
   (( status == 0 ))

   run_ellah 'modules/core-dependencies'
   (( status == 0 ))
}

@test 'core-dependencies does not run if brew is missing' {
   export PATH="/bin:/usr/bin:$ELLAH_ROOT/bin/"

   run command -v brew
   (( status == 1 ))

   run_ellah 'modules/core-dependencies'
   (( status == 1 ))
}
