#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

apt list --installed | cut -d/ -f1 | egrep -v '^$' | \
while read paquete; do
	echo "Procesando $paquete:"
	apt-get download "$paquete" 2>/dev/null
	filename=$(find -type f | egrep -i "$paquete")
	dpkg-deb -x "$filename" debcontents/
	while read linea; do
		owngrp=$(echo "$linea" | cut -d\; -f1)
		mod=$(echo "$linea" | cut -d\; -f2)
	 	ruta=$(echo "$linea" | cut -d\; -f3 | cut -d/ -f2-)
	 	echo -n $(stat --format=%U:%G\;%a "/$ruta")
	 	chown "$owngrp" "/$ruta"
	 	chmod "$mod" "/$ruta"
		echo " --> "$(stat --format=%U:%G\;%a "/$ruta")" : /$ruta"
	done < <(find debcontents/ -exec stat --format=%U:%G\;%a\;%n {} \;)
	rm "$filename"
	rm -rf debcontents/*
	sleep 5
done
