#!/usr/bin/env bats

load '../test-helper'

setup() {
   rm -rf ${LABORATORY:?}/*
}

@test 'set_context fails without context paramter (argument 1)' {
   run set_context
   (( status == 1 ))
   [[ $output =~ 'parameter null or not set' ]]
}

@test 'set_context fails when $LABORATORY is not set' {
   unset LABORATORY

   run set_context 'will-fail-anyway'
   (( status == 1 ))
   [[ $output =~ 'parameter null or not set' ]]
   [[ ! -d ${LABORATORY}/will-fail-anyway ]]
}

@test 'set_context will work but will emit a warning when log function is not set' {
   unset log

   run set_context 'smoke'
   (( status == 0 ))
   [[ $output =~ 'log: command not found' ]]
   [[ -d ${LABORATORY}/smoke ]]
}

@test 'set_context will create a new directory' {
   run set_context 'uninitialized-context'
   (( status == 0 ))
   [[ -d ${LABORATORY}/uninitialized-context ]]
}

@test 'set_context will backup a file that clashes' {
   touch "${LABORATORY}/context-clashes-with-file"
   [[ -f ${LABORATORY}/context-clashes-with-file ]]

   run set_context 'context-clashes-with-file'
   (( status == 0 ))
   [[ -d ${LABORATORY}/context-clashes-with-file ]]
   [[ -f ${LABORATORY}/context-clashes-with-file-backup ]]
}

@test 'set_context will remove a symlink that clashes' {
   ln -s ~/blerg "${LABORATORY}/context-clashes-with-symlink"
   [[ -h ${LABORATORY}/context-clashes-with-symlink ]]

   run set_context 'context-clashes-with-symlink'
   (( status == 0 ))
   [[ -d ${LABORATORY}/context-clashes-with-symlink ]]
}

@test 'set_context will move into the context' {
   (
      set_context 'my-context'
      touch {a,b,c}
   )

   [[ -f ${LABORATORY}/my-context/a ]]
   [[ -f ${LABORATORY}/my-context/b ]]
   [[ -f ${LABORATORY}/my-context/c ]]
}
