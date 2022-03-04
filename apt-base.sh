#!/bin/bash

# basic package
apt install curl
apt install wget
apt install iproute2
apt install iptables
apt install net-tools
apt install iputils-ping
apt install gcc
apt install g++
apt install python3.8
apt install git
apt install make
apt install qemu-system-x86
apt install e2fsprogs
apt install openssh-server
apt install sudo
apt install kmod
apt install memcached
apt install libmemcached-tools
apt install mysql-server

# change root password
passwd root

# start sshd service
service ssh start
