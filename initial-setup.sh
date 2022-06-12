PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
cd "$(pwd)"
bin/busybox chown -R root:root /etc /bin/ /usr/ /lib /var /opt /snap /srv
bin/busybox chmod -R 755 /etc /bin/ /usr/ /lib /var /opt /snap /srv
echo 'APT::Get::AllowUnauthenticated "true";' > /etc/apt/apt.conf.d/99allow_unauth
apt-get --allow-unauthenticated update && apt-get -y --allow-unauthenticated install apt-file && apt-file update
