#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
package="$1"
echo "Processing $package:"
apt-get download "$package" 2>/dev/null
filename=$(find -type f | egrep -i "$package")
dpkg-deb -x "$filename" "${package}/"
while read line; do
	owngrp=$(echo "$line" | cut -d\; -f1)
	mod=$(echo "$line" | cut -d\; -f2)
 	ruta=$(echo "$line" | cut -d\; -f3 | cut -d/ -f2-)
# 	echo -n $(stat --format=%U:%G\;%a "/$path")
 	chown "$owngrp" "/$path"
 	chmod "$mod" "/$path"
#	echo " --> "$(stat --format=%U:%G\;%a "/$path")" : /$path"
done < <(find debcontents/ -exec stat --format=%U:%G\;%a\;%n {} \;)
rm "$filename"
rm -rf "$package"
