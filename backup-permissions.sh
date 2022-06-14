#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
BACKUPPATH="$1"
BACKUPFILE="$2"
rm -f "$BACKUPFILE"
CURDIR=$(pwd)
cd "$BACKUPPATH"
find . -mount | \
while read line; do
#	owngrp=$(echo "$line" | cut -d\; -f1)
#	mod=$(echo "$line" | cut -d\; -f2)
# 	ruta=$(echo "$line" | cut -d\; -f3 | cut -d/ -f2-)
 	stat --format=%U:%G\;%a\;%n "$ruta" | tee -a "$BACKUPFILE"
done
cd "$CURDIR"
