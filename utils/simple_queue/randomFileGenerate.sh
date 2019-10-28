#!/bin/bash
CLIENT_IP=$1

source ~/CLIK/config.ini

SEED=$(head -1 /dev/urandom | od -N 4 | awk '{ print $2 }')
RANDOM=$SEED

#Debug script..
echo "Client ${1} random file generate"

echo -n > "${RANDOM_FILE}_${CLIENT_IP}" 

for i in {1..1000}
do
	echo `expr ${RANDOM}` >> "${RANDOM_FILE}_${CLIENT_IP}"
done

