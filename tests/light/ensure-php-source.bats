#!/usr/bin/env bats

load '../test_helper'

VALID_VERSION=5.6.20

@test 'ensure-php-source fails without PHP_VERSION' {
   run run-module 'ensure-php-source'
   (( status == 1 ))
}

@test 'ensure-php-source fails with invalid PHP_VERSION' {
   skip
   export PHP_VERSION=invalid-version
   run run-module 'ensure-php-source'
   (( status == 1 ))
   [[ $output =~ "Could not ensure php $PHP_VERSION" ]]
}

@test "ensure-php-source works with a valid version ($VALID_VERSION)" {
   skip
   export PHP_VERSION=$VALID_VERSION
   run run-module 'ensure-php-source'
   (( status == 0 ))
}

