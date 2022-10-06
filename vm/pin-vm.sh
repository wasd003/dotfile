#!/bin/bash

qemu_pid=$(sudo cat /tmp/jch-vm.pid)
cpu_nr=$(qemu-affinity -v --dry-run -- $qemu_pid|grep CPU|wc -l)
begin_pcpu=2
end_pcpu=$(( $begin_pcpu + 2 * $cpu_nr - 1 ))
backend_core=$(( $end_pcpu + 1 ))

# pin vcpu thread
echo "Try to pin vcpu thread... qemu-system pid:"$qemu_pid
qemu-affinity $qemu_pid -k $(seq $begin_pcpu 2 $end_pcpu)
qemu-affinity -v --dry-run -- $qemu_pid

# pin vhost thread
echo "Try to pin vhost thread..."
for vhost_pid in $(pgrep vhost-$qemu_pid); do
	taskset -cp $backend_core $vhost_pid
	backend_core=$((backend_core + 1))
done
