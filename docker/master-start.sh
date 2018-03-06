#!/bin/bash
# master-start.sh
/etc/init.d/redis-server start
/etc/init.d/xvfb start

cd /evolution-strategies-starter

LOGDIR=/logdir/es_master_`date +%Y%m%d%H%M`

mkdir -p ${LOGDIR}

python3 -m es_distributed.main master --exp_file /humanoid.json \
    --log_dir ${LOGDIR} \
    --master_socket_path /var/run/redis/redis.sock
