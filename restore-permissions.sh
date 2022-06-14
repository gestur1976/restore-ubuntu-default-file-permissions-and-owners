#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
BACKUPPATH="$1"
BACKUPFILE="$2"
CURDIR=$(pwd)
cd "$BACKUPPATH"
cat "$BACKUPFILE" | \
while read line; do
	owngrp=$(echo "$line" | cut -d\; -f1)
	mod=$(echo "$line" | cut -d\; -f2)
 	ruta=$(echo "$line" | cut -d\; -f3 | cut -d/ -f2-)
 	echo "Settings $owngrp;$mod to $ruta"
 	chown "$owngrp" "$ruta"
 	chmod "$mod" "$ruta"
done
cd "$CURDIR"
