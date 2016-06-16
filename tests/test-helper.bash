
# NOTE: tests that load this helper should be in a path which requires two traversals up to reach ellah-root
# eg. `ellahRoot/tests/something/whatevs.bat` or `ellahRoot/blerg/bloop/whatevs.bat`

export ELLAH_ROOT=$BATS_TEST_DIRNAME/../..
export LABORATORY=$BATS_TMPDIR/lab

for coreFunction in "${ELLAH_ROOT?}"/core/functions/*.bash; do
   source "$coreFunction" || {
      echo "importing core function '$coreFunction' failed" >&2
      return 1
   }
done
