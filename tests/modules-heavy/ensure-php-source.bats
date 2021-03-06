#!/usr/bin/env bats

load '../test-helper'

validVersions=(5.6.20 7.4.0)

@test 'ensure-php-source fails without PHP_VERSION' {
   run_ellah 'modules/ensure-php-source'
   (( status == 1 ))
   [[ $output =~ "'PHP_VERSION' variable is empty" ]]
}

@test 'ensure-php-source fails with invalid PHP_VERSION' {
   export PHP_VERSION=invalid-version
   run_ellah 'modules/ensure-php-source'
   (( status == 1 ))
   [[ $output =~ Could\ not\ ensure\ php\ $PHP_VERSION ]]
}

@test "ensure-php-source works with valid versions (${validVersions[*]})" {
   export PHP_VERSION
   for PHP_VERSION in "${validVersions[@]}"; do
      run_ellah 'modules/ensure-php-source'
      (( status == 0 ))
   done
}
