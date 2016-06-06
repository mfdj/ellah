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
   # echo 'setup happens for each test' >&2
}

teardown() {
   # echo 'teardown happens for each test' >&2
   :
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
#   $status (exit code)
#   $output (contets of STDOUT)
#   $lines  (lines array of STDOUT)
#     "${lines[0]}" is line-1

@test 'echo mvp' {
   run echo mvp
   assert_success
   [ "$output" == mvp ]
}

@test 'ls odb' {
   run ls -l1 "$odb"
   [ "${lines[0]}" == bee ]
}

@test 'assert failure [ … ]' {
   run false
   [ "$status" -eq 1 ]
}

@test 'assert failure [[ … ]]' {
   run false
   [[ $status -eq 1 ]]
}

@test 'assert failure (( … ))' {
   run false
   (( status == 1 ))
}

@test 'assert success [ … ]' {
   run true
   [ "$status" -eq 0 ]
}

@test 'assert success [[ … ]]' {
   run true
   [[ $status -eq 0 ]]
}

@test 'assert success (( … ))' {
   run true
   (( status == 0 ))
}



