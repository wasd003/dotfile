#!/bin/bash

# Configure SR-IOV for RDMA with Eth Mode

netdev=enp1s0np0
vf_num=32

# 1. enable sriov. more detail refers to enable_sriov in ib-sriov.sh
echo "$vf_num" > /sys/class/net/$netdev/device/mlx5_num_vfs

# 2. config vf
sudo ip link set $netdev vf 0 trust on
sudo ip link set $netdev vf 0 mac 56:3f:8a:ad:7d:2a

# 3. detach vf. more detail refers to detach_vf in ib-sriov.sh
# virsh nodedev-reattach $pci_virsh_fmt

# 4. check by ip link show
ip link show dev $netdev
