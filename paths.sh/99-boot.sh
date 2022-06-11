#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
echo Fixing /boot permissions
cd /boot
chown root:root *
chmod 644 *
chmod 600 System.map* vmlinuz*
chmod -R 755 efi
echo Regenerating initrd:
echo update-initramfs -k all -u
update-initramfs -u -k all
echo "Recreating grub entries.."
update-grub
echo Done!
sleep 5
