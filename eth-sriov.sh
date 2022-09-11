#!/bin/bash

# Configure SR-IOV for ConnectX-4/ConnectX-5/ConnectX-6 with KVM (Ethernet)

netdev=enp1s0np0
vf_num=32

# /etc/init.d/mlnx-en.d restart

echo "$vf_num" > /sys/class/net/$netdev/device/mlx5_num_vfs
#check vf by lspci or ip link show

vf_pci=0000:05:00.6
vf_mac=00:22:33:44:55:66
echo $vf_pci > /sys/bus/pci/drivers/mlx5_core/unbind
ip link set $netdev vf 0 mac 
echo $vf_pci > /sys/bus/pci/drivers/mlx5_core/bind
#check by ip link show
