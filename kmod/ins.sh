#!/bin/bash

k_mod=test_kprobe
if (( $(lsmod|grep $k_mod|wc -l) > 0 )); then
	sudo rmmod ${k_mod}
fi
sudo insmod $k_mod.ko
