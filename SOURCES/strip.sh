#!/bin/sh

if [ -z "$1" ]; then
	echo "usage $0 version"
	exit 1;
fi
if [ ! -f php-$1.tar.bz2 ]; then
	echo "missing php-$1.tar.bz2 archive"
	exit 2;
fi
old=$(mktemp)
new=$(mktemp)

echo "Untar..."
tar xf php-$1.tar.bz2
rm -rf php-$1/ext/json
echo "Tar..."
tar cJf  php-$1-strip.tar.bz2 php-$1

echo "Diff..."
tar tf php-$1.tar.bz2 | sort >$old
tar tf php-$1-strip.tar.bz2 | sort >$new
diff $old $new

rm -rf $old $new php-$1 php-$1.tar.bz2
