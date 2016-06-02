#!/usr/bin/env bats

# BATS-globals
#   BATS_TMPDIR       : /tmp/folders/< random name >
#   BATS_TEST_DIRNAME : the directory of this file

odb=$BATS_TMPDIR/old-dirty-boolean

# BATS-hooks
#   setup() { … }
#   teardown() { … }

setup() {
   mkdir -p "$odb"
   touch "$odb"/{eh,bee,see}
   echo 'setup happen for each test' >&2
}

teardown() {
   echo 'ditto teardown' >&2
}

# custom user function

assert_success() {
   if [ "$status" -ne 0 ]; then
      echo "command failed with exit status $status"
      exit 1
   fi
}

# BATS-run
#   run < your test commnad >
# then have access to
#   $output (contets of STDOUT)
#   $status (exit code)
#   $lines  (lines array)
#     "${lines[0]}" is line-1

@test "echo mvp" {
   run echo mvp
   assert_success
   [ "$output" == mvp ]
}

@test "ls odb" {
   run ls -l1 "$odb"
   [ "${lines[0]}" == bee ]
}
