#!/bin/bash

INSTALL=/path/to/ofed/mlnxofedinstall
KERN_SRC=/path/to/kernel

sudo $INSTALL      \
    --add-kernel-support    \
    --kernel-sources $KERN_SRC \
    --without-iser-modules  \
    --without-isert-modules \
    --without-srp-modules
