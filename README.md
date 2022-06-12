# restore-ubuntu-default-file-permissions-and-owners

DESCRIPTION:

This will be a set of scripts to restore main file and folder permissions for a damaged Ubuntu installation.
It also recovers most of accidentally deleted files by reinstalling all packages.

This script is intended to quickly restore Ubuntu functionality if you accidentally ran chmod -R or chown -R or rm -rf an entire tree
(like /bin, /usr, /lib).

HOW TO USE:

Most of the times you'll need to boot from a live disk with Internet access unless your installation still boots and has networking functionality.
In this case you only need to download and unpack the file to a temporary folder and run the scripts below. It uses busybox, so you don't need any
working binary at least to do the initial setup.

If you boot from a live disk (I.E. Ubuntu Desktop Installer), first of all you need to mount your damaged Ubuntu installation:

Open a terminal and type:

sudo -i

mount /dev/sdx[n] /mnt   # Where sdx[n] is your disk and partition. For example /dev/sda1

mount --rbind /dev /mnt/dev

mount --rbind /sys /mnt/sys

mount --rbinb /proc /mnt/proc

mount --rbind /run /mnt/run


Download and unpack file contents to a temporary folder inside /mnt (like /mnt/mnt)

chroot /mnt
cd /tmp/restore-ubuntu-default-file-permissions-and-owners
./initial-setup.sh
./package-repair.sh

LIMITATIONS:

It only repairs original package file and folder permissions. All new added files are left unchanged and need to be repaired manually.
