#!/bin/bash

ssh $SSH_HOST "bash /path/to/start-print.sh"
wrk -t8 -c64 -d1s https://$HOST/128kb.bin
ssh $SSH_HOST "bash /path/to/stop-print.sh"
