#!/usr/bin/env bats

load '../test-helper'

@test 'use fails without arguments' {
   run use
   (( status == 1 ))
   [[ $output =~ 'parameter null or not set' ]]
}

@test 'use fails when $ELLAH_ROOT is not set' {
   unset ELLAH_ROOT
   run use 'some/arbitray/thing'
   (( status == 1 ))
   [[ $output =~ 'parameter null or not set' ]]
}

@test 'use will work but will emit a warning when log function is not set' {
   unset log
   export PATH=/bin # because /usr/bin/log is a thing

   run use 'functions/smoke'
   (( status == 0 ))
   [[ $output =~ 'log: command not found' ]]
}

@test 'use fails when it cant resolve the file' {
   run use 'functions/smoke'
   (( status == 0 ))
}

@test 'use will source a file into the current context' {
   run smoke
   (( status == 127 ))

   use 'functions/smoke'
   run smoke
   (( status == 0 ))
}
