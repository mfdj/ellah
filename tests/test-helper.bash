#!/bin/bash
# NOTE: tests that load this helper should be in a path which requires two traversals up to reach ellah-root
# eg. `ellahRoot/tests/something/whatevs.bat` or `ellahRoot/blerg/bloop/whatevs.bat`

export ELLAH_ROOT=$BATS_TEST_DIRNAME/../..
export LABORATORY=$BATS_TMPDIR/lab
export PATH="$ELLAH_ROOT/bin:$PATH"

run_ellah_module() {
   run "$ELLAH_ROOT/modules/$1.sh"
}
