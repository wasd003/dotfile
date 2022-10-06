mnt=mnt_qcow2

sudo umount $mnt/proc
sudo umount $mnt/sys
sudo umount $mnt/dev/pts
sudo umount $mnt/dev
sudo umount $mnt
sleep 2
sudo qemu-nbd --disconnect /dev/nbd0
