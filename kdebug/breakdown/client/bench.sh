#!/bin/bash

ssh $SSH_HOST "bash /path/to/clear-stat.sh"
ssh $SSH_HOST "bash /path/to/start-record.sh"
wrk -t8 -c64 -d30s https://$HOST/128kb.bin
ssh $SSH_HOST "bash /path/to/stop-record.sh"
