#!/bin/bash
# worker-start.sh
/etc/init.d/redis-server start
/etc/init.d/xvfb start

cd /evolution-strategies-starter

python3 -m es_distributed.main workers --master_host redis \
    --relay_socket_path /var/run/redis/redis.sock --num_workers 1
