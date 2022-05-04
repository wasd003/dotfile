#!/bin/bash

# Network & Hostname
hostname=broadwell
gateway=192.168.25.164
eth0_ip=192.168.25.51/20
ip link set eth0 up
ip addr add $eth0_ip dev eth0 
ip route add default via $gateway
ip link set lo up
ip addr add 127.0.0.1/8 dev lo
echo "nameserver 114.114.114.114" > /etc/resolv.conf
echo "127.0.0.1    localhost.localdomain localhost" > /etc/hosts
echo "127.0.0.1    $hostname" >> /etc/hosts
echo $hostname > /etc/hostname

# Log Leval
echo "7 4 1 7" > /proc/sys/kernel/printk

# auto boot entry
service ssh start

bash
