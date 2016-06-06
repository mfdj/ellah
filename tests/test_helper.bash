
export ELLAH_ROOT=$BATS_TEST_DIRNAME/..
export LABORATORY=$BATS_TMPDIR/lab

source "${ELLAH_ROOT?}/_core-functions.bash" || {
  echo 'could not load ellah-core' >&2
  return 1
}


