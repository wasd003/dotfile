#!/bin/bash

FLAME=/root/FlameGraph

perf script -f|$FLAME/stackcollapse-perf.pl|$FLAME/flamegraph.pl>flame.svg
