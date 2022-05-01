#!/bin/bash

qemu_pid=$(ps aux|grep qemu|grep -v grep|awk '{print $2}'|tail -1)
echo "Try to pin vcpu thread... qemu-system pid:"$qemu_pid
qemu-affinity $qemu_pid -k 6 7 8 9
qemu-affinity -v --dry-run -- $qemu_pid

echo "Try to pin vhost thread..."
core=10
for vhost_pid in `pgrep vhost-`; do
	taskset -cp $core $vhost_pid
	core=$((core + 1))
done
