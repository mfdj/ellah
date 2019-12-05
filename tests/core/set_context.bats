#!/usr/bin/env bats

load '../test-helper'

setup() {
   rm -rf ${ELLAH_LAB:?}/*
}

@test 'set_context fails without context paramter (argument 1)' {
   run_ellah core/functions/set_context
   (( status == 1 ))
   [[ $output =~ parameter\ null\ or\ not\ set ]]
}

@test 'set_context will create a new directory' {
   [[ ! -d ${ELLAH_LAB}/uninitialized-context ]]
   run_ellah core/functions/set_context 'new-context'
   (( status == 0 ))
   [[ -d ${ELLAH_LAB}/new-context ]]
}

@test 'set_context will backup a file that clashes' {
   touch "${ELLAH_LAB}/context-clashes-with-file"
   [[ -f ${ELLAH_LAB}/context-clashes-with-file ]]

   run_ellah core/functions/set_context 'context-clashes-with-file'
   (( status == 0 ))
   [[ -d ${ELLAH_LAB}/context-clashes-with-file ]]
   [[ -f ${ELLAH_LAB}/context-clashes-with-file-backup ]]
}

@test 'set_context will remove a symlink that clashes' {
   ln -s ~/blerg "${ELLAH_LAB}/context-clashes-with-symlink"
   [[ -h ${ELLAH_LAB}/context-clashes-with-symlink ]]

   run_ellah core/functions/set_context 'context-clashes-with-symlink'
   (( status == 0 ))
   [[ -d ${ELLAH_LAB}/context-clashes-with-symlink ]]
}

@test 'set_context will move into the context' {
   skip
   (
      set_context 'my-context'
      touch {a,b,c}
   )

   [[ -f ${ELLAH_LAB}/my-context/a ]]
   [[ -f ${ELLAH_LAB}/my-context/b ]]
   [[ -f ${ELLAH_LAB}/my-context/c ]]
}
