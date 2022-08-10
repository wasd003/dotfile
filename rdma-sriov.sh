#!/bin/bash

# variable example
#   netdev - ib0
#   ibdev - mlx5_0
#   hca_path - /dev/mst/mt4123_pciconf0

# default vf number
vf_nr=32

test_mode=false

# enable sriov for rdma nic
enable_sriov() {
    # enable OFED driver
    # mst start
    # systemctl restart opensm

    hca_path=$(mst status | grep "/dev/mst" | awk '{print $1}')
    netdev=$( ibdev2netdev|head -1|awk '{print $5}' )
    sriov_en=$(mlxconfig -d $hca_path q | \
        grep "SRIOV_EN" | awk '{print $2}')
    echo "[Detect] hca_path:${hca_path} netdev:${netdev} sriov_en:${sriov_en}"

    if [[ "$sriov_en" != "True(1)" ]]; then
        echo "rdma sriov hasn't been enabled, enabling..."
        [[ $test_mode == true ]] && \
            echo "do nothing because of test mode" && \
            exit 0
        read -p "please input VF Number: " vf_nr
        mlxconfig -d $hca_path set SRIOV_EN=1 NUM_OF_VFS=$vf_nr
        # after enabling sriov, reboot is needed. therefore, exit anyway
        exit 0
    else
        vf_nr=$(cat /sys/class/net/$netdev/device/sriov_totalvfs)
        echo "SRIOV has already been enabled, totalvfs:${vf_nr}"
    fi

    echo "set current vf number:${vf_nr}"
    echo $vf_nr > /sys/class/net/$netdev/device/sriov_numvfs
}

# @idx - vf number which ranges in [1, $vf_nr]
idx2pci_nr() {
    idx=$1
    # sed starts from 1 && first line of ibdev2netdev is pf
    # skip pf anyway
    line_nr=$(($idx + 1))
    pci_nr=$(ibdev2netdev -v | \
        sort -k 1 | \
        sed -n "${line_nr} p" | \
        awk '{print $1}')
    echo "$pci_nr"
}

# enable virtual function
# @idx - vf number which ranges in [1, $vf_nr]
enable_vf() {
    idx=$1
    pci_nr=$(idx2pci_nr $idx)
    guid_idx=$(( ($idx-1)*2+1 ))
    port_idx=$(( $guid_idx+1 ))
    (( $guid_idx < 10 )) && guid_idx="0"$guid_idx
    (( $port_idx < 10 )) && port_idx="0"$port_idx
    guid="06:3f:72:03:00:d4:56:"$guid_idx
    port="06:3f:72:03:00:d4:56:"$port_idx
    echo "vf_idx:$idx pci_nr:$pci_nr guid:$guid port:$port"

    if [[ $test_mode == false ]]; then
        # VF in /sys starts from zero
        idx=$(($idx-1))
        echo $pci_nr > /sys/bus/pci/drivers/mlx5_core/unbind
        echo $guid > /sys/class/infiniband/mlx5_0/device/sriov/$idx/node
        echo $port > /sys/class/infiniband/mlx5_0/device/sriov/$idx/port
        echo $pci_nr > /sys/bus/pci/drivers/mlx5_core/bind
        echo Follow > /sys/class/infiniband/mlx5_0/device/sriov/$idx/policy
    fi
}

# detach vf from host, so it can be used by vm
# after detachment, ibdev can't be detected via ibdev2netdev nor ibstat
detach_vf() {
    # first line is pf, skip it anyway
    for ((  ;$(ibdev2netdev -v|wc -l) > 1; )); do
        pci_nr=$( ibdev2netdev -v|sed -n '2p'|awk '{print $1}' )
        pci_virsh_fmt=$(echo $pci_nr | \
            awk -F '[:.]' '{print "pci_"$1"_"$2"_"$3"_"$4}')
        echo "[Detach] pci_nr:$pci_nr pci_virsh_fmt:$pci_virsh_fmt"
        [[ $test_mode == false ]] && \
            virsh nodedev-detach $pci_virsh_fmt
    done
}

reattach_vf() {
	for (( i=1; i<=32; i++ )); do
		pci_nr=$(awk '{print $4}' vf_pci|sed -n "$i p")
        	pci_virsh_fmt=$(echo $pci_nr | \
        	    awk -F '[:.]' '{print "pci_"$1"_"$2"_"$3"_"$4}')
        	echo "[Reattach] pci_nr:$pci_nr pci_virsh_fmt:$pci_virsh_fmt"
    		virsh nodedev-reattach $pci_virsh_fmt
	done
}

main() {
    [[ $(whoami) != "root" ]] && \
        echo "Please run me as root :)" && \
        exit 0

    [[ $1 == test ]]  && test_mode=true

    # reattach_vf

    enable_sriov

    # enable each vf
    for (( i = 1; i <= $vf_nr; i ++ )); do
        enable_vf $i
    done

    detach_vf
}

main $@
