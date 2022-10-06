#!/bin/bash

# basic package
sudo apt -y install \
	curl \
	wget \
	iproute2 \
	iptables \
	net-tools \
	iputils-ping \
	gcc \
	g++ \
	python3.8 \
	git \
	make \
	qemu-system-x86 \
	e2fsprogs \
	openssh-server \
	sudo \
	kmod \
	memcached \
	libmemcached-tools \
	mysql-server \
    texlive-full \

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
