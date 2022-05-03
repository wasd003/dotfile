#!/bin/bash

# QEMU Parameter Example
# https://blog.katastros.com/a?ID=01700-b8d7b378-7800-4354-8201-6743cfa32f85

# Network Virtualization
# SRIOV
# -device vfio-pci,host=5e:00.1,id=mydev0 \

# Virtio-NET MQ
# -device virtio-net-pci,netdev=vnet,vectors=10,mq=on -netdev tap,id=vnet,vhost=on,ifname=tap0,script=no,queues=4 $@ \

# Virtio-NET SQ
# -device virtio-net-pci,netdev=vnet -netdev tap,id=vnet,vhost=on,ifname=tap1,script=no $@ \

kernel_path=/home/jch/Documents/guest-linux
qemu_path=/home/jch/Documents/qemu-6.2.0
build=/home/jch/Documents/run-linux/build

create_tapk() {
	tap=tap$1
	if ! [ -e /sys/class/net/$tap ]; then
	    echo -n "Creating tap..."
	    sudo ip tuntap add $tap mode tap user $(whoami)
	    sudo ip link set $tap master br0
	    sudo ip link set dev $tap up
	fi
}

sudo iptables -P FORWARD ACCEPT
create_tapk 0
create_tapk 1

rm vm.log

sudo $qemu_path/build/qemu-system-x86_64 \
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
	-device virtio-net-pci,netdev=vnet,vectors=10,mq=on -netdev tap,id=vnet,vhost=on,ifname=tap1,script=no,queues=4 $@ \
        | tee vm.log
