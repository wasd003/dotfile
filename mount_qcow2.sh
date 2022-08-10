#!/bin/bash

DISK=sync-test.qcow2
mnt=mnt_qcow2

sudo qemu-nbd --connect=/dev/nbd0 $DISK
sleep 2
sudo mount /dev/nbd0p1 $mnt
sudo mount -t proc /proc $mnt/proc
sudo mount -t sysfs /sys $mnt/sys
sudo mount -o bind /dev $mnt/dev
sudo mount -o bind /dev/pts $mnt/dev/pts
sudo chroot $mnt /bin/bash
