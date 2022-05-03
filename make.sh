#!/bin/bash
	
assets=$(pwd)/assets
build=$(pwd)/build

check_assets() {
	if [[ ! -d $assets || ! -d $assets/initramfs ]]; then
		sudo rm -r $assets
		echo "assets dir not found, downloading......"
		git clone https://github.com/wasd003/assets.git $assets
		cd $assets; gunzip initramfs.cpio.gz;
		mkdir initramfs; mv initramfs.cpio initramfs;
		cd initramfs; cpio -idmv < initramfs.cpio
	fi
}

build_rootfs() {
	read -p "please input image name: " img_name
	read -p "please input image size(GB): " img_size
	img=$img_name.img
	mnt_folder=/mnt/$img_name
	dd if=/dev/zero of=$img bs=1G count=$img_size
	sudo mkfs.ext4 $img 
	sudo mkdir -p $mnt_folder 
	sudo rm -rf $mnt_folder/*
	sudo mount -o loop $img $mnt_folder
	echo "create image successfully"

	sudo tar -xpvf $assets/ubuntu-base-20.04.2-base-amd64.tar.gz -C $mnt_folder
	mv $img $build/
	sudo umount $mnt_folder
	sudo rm -rf $mnt_folder
	echo "create disk with rootfs successfully"
}

build_initramfs() {
	mkdir -p $assets/initramfs
	cd $assets/initramfs
	find . -print0 | cpio --null -ov --format=newc \
		  | gzip -9 > $build/initramfs.cpio.gz
}

create_br0() {
	if ! [ -e /sys/class/net/br0 ]; then
		echo "br0 unavailable, creating..."
		# dhcp_ip: host ip which is allocated by dhcp server
		# eth0: indicates which interface owns dhcp_ip currently
		dhcp_ip=192.169.1.1/24
		eth0=eno4
        sudo ip link add br0 type bridge
		sudo ip link set br0 up
		sudo ip addr add $dhcp_ip dev br0
		sudo ip addr flush dev $eth0
		sudo ip link set $eth0 master br0
    fi
}

create_tapk() {
	# firewall settings
	sudo iptables -P FORWARD ACCEPT

	# add tapk and connect it to bridge
    sudo ip link del tap$1
	sudo ip tuntap add tap$1 mode tap user $(whoami)
	sudo ip link set tap$1 master br0
    sudo ip link set dev tap$1 up
}

build() {
	build_rootfs
	build_initramfs
	create_br0
	create_tapk 0
}

fastbuild() {
	build_initramfs
	create_br0
	create_tapk 0
}

help() {
	echo "build: build rootfs && initramfs && tap"
	echo "fastbuild: build initramfs && tap"
	echo "mkimg: make img"
	echo "mkrf: make initramfs"
	echo "mktk [num]: make tapk which connects to br0"
}

main() {
	if (( $# == 0  )); then
		echo "please input at least one argument, type help to learn usage :)"
		return
	fi
	mkdir -p build
	check_assets
	if [ $1 = "help" ]; then
		help
	elif [ $1 = "build" ]; then
		build
	elif [ $1 = "fastbuild" ]; then
		fastbuild
	elif [ $1 = "mkimg" ]; then
		build_rootfs
	elif [ $1 = "rmimg" ]; then
		clean_rootfs
	elif [ $1 = "mkrf" ]; then
		build_initramfs
	elif [ $1 = "mktk" ]; then
		create_tapk $2
	fi
}

main $@
