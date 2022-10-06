#!/bin/bash

SSH_HOST=wasd003@hostname

ssh -fn $SSH_HOST "bash /root/start-perf.sh"
# run benchmark
ssh $SSH_HOST "bash /root/stop-perf.sh"
