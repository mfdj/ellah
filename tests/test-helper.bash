
# NOTE: tests that load this helper should be in a path which requires two traversals up to reach ellah-root
# eg. `ellahRoot/tests/something/whatevs.bat` or `ellahRoot/blerg/bloop/whatevs.bat`

export ELLAH_ROOT=$BATS_TEST_DIRNAME/../..
export LABORATORY=$BATS_TMPDIR/lab

source "${ELLAH_ROOT?}/_core-functions.bash" || {
  echo 'could not load ellah-core' >&2
  return 1
}
