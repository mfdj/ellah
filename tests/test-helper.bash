#!/bin/bash

# NOTE: tests that load this helper should be in a path which requires two traversals
# up to reach ellah-root eg. `ellah-root/tests/something/this.bat`
# or `ellah-root/blerg/bloop/whatevs.bat`
export ELLAH_ROOT=$BATS_TEST_DIRNAME/../..
export ELLAH_LAB=$BATS_TMPDIR/lab
export PATH="$ELLAH_ROOT/bin:$PATH"

run_ellah() {
   local path=$1
   shift
   run "$ELLAH_ROOT/$path"* "$@"
}
