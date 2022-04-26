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

# install memaslap on ubuntu
# wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
# tar -xzvf libmemcached-1.0.18.tar.gz
# cd libmemcached-1.0.18/
# ./configure --enable-memaslap
# vim Makefile
# 修改4708行，行尾添加-lpthread
# vim clients/memflush.cc
# 修改42行和52行，由if (opt_servers == false)改为if (!opt_servers)
# make && make install
