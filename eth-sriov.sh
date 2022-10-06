#!/bin/bash

# Configure SR-IOV for RDMA with Eth Mode

netdev=enp1s0np0
vf_num=32

# /etc/init.d/mlnx-en.d restart

echo "$vf_num" > /sys/class/net/$netdev/device/mlx5_num_vfs

sudo ip link set $netdev vf 0 trust on
sudo ip link set $netdev vf 0 mac 56:3f:8a:ad:7d:2a

# check by ip link show
ip link show dev $netdev
