#!/bin/bash

# qemu line parameter example 
# https://blog.katastros.com/a?ID=01700-b8d7b378-7800-4354-8201-6743cfa32f85

kernel_path=/home/ldj/nfs/jch-backup/guest-linux
build=/home/ldj/nfs/jch-backup/run-linux/build

# sudo qemu-system-x86_64 \
    #-serial tcp:localhost:44320 \

rm vm.log

# sriov nic
# -device vfio-pci,host=5e:00.1,id=mydev0 \

sudo /home/ldj/nfs/jch-backup/run-linux/qemu-6.2.0/build/qemu-system-x86_64 \
	-name vm,debug-threads=on \
	-cpu host \
	--enable-kvm \
	-smp 4 \
    -m 8G \
	-nographic \
	-append "console=ttyS0 nokaslr" \
	-kernel $kernel_path/arch/x86/boot/bzImage \
	-initrd $build/initramfs.cpio.gz \
	-device virtio-blk-pci,drive=vdisk -drive if=none,id=vdisk,format=raw,file=$build/vmdisk.img \
    -device virtio-net-pci,netdev=vnet,mac=52:54:00:12:34:88 -netdev tap,id=vnet,vhost=on,ifname=tap1,script=no \
    | tee vm.log
