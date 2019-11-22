
log info 'This module is out of sync and should not be run'
exit 0

echo
echo '---------- download apache source ----------'

cd $source_cache

echo "• Get $version archive"
[[ $CLEAN_SOURCE ]] && clean_path httpd-${apache_version}.tar.bz2{,.sha1}

if [[ ! -f httpd-${apache_version}.tar.bz2 ]]; then
   wget http://www.eu.apache.org/dist/httpd/httpd-${apache_version}.tar.bz2 || exit
fi

echo '• Get sha1-fingerprint'
if [[ ! -f httpd-${apache_version}.tar.bz2.sha1 ]]; then
   wget https://www.apache.org/dist/httpd/httpd-${apache_version}.tar.bz2.sha1 || exit
fi

echo '• Verifying archive'
sha1sum -c httpd-${apache_version}.tar.bz2.sha1 || exit

echo '• Decompressing archive'
# x: decompress, f: read a file instead of stdin, v: verbose
[[ $clean_build ]] && remove_path httpd-${apache_version}
tar xf httpd-${apache_version}.tar.bz2
du -hs httpd-${apache_version}

ls -la
echo this is a remidner that this is a debugging exit
exit

echo
echo '---------- compile apache ----------'
[[ $clean_build ]] && clean_path $apache_build_path

if [[ ! -d php-${php_version} ]]; then
tar xf php-${php_version}.tar.gz
du -hs php-${php_version}
fi

cd httpd-${apache_version}

./configure --prefix=${apache_build_path} \
          --enable-so # loadable module support

make && make install
