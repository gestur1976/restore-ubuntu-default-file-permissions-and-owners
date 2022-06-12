#!/bin/bash
PATH="$(pwd)/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
HOMEDIR=$(pwd)
cd "$HOMEDIR"
apt list --installed | tail -n +2 | cut -d/ -f1 | egrep -v '^$' | \
while read package; do
        echo "Fixing $package permissions:"
        threads=$(ps ax | grep -v grep | grep -c process-package.sh)
        while [ "$threads" -gt "30" ]; do
                sleep 1
                threads=$(ps ax | grep -v grep | grep -c process-package.sh)
#               echo "Active processes $threads"
        done
        ./process-package.sh "$package" >/dev/null 2>/dev/null & 
        sleep 0.1
done
threads=$(ps ax | grep -v grep | grep -c "process-package.sh")
while [ "$threads" -gt "1" ]; do
        echo "Waiting for $threads to end..."
        sleep 1
        threads=$(ps ax | grep -v grep | grep -c "process-package.sh")
done
rm ./*.deb
apt-get update && apt-get -y --allow-unauthenticated install apt-file aptitude && apt-file update
echo
echo "Reinstalling all packages with aptitude to fix remaining permissions and recover accidentally deleted files..."
apt list --installed | tail -n +2 | cut -d/ -f1 | egrep -v '^$' | \
while read package; do
        echo "Reinstalling $package:"
        aptitude -y reinstall "$package"
done
