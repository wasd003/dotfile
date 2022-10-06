#!/bin/bash

sudo perf record -F 100 -p $(pgrep vhost|sed 's/^\|$//g'|paste -sd,) -g --call-graph dwarf -o perf.data
