#!/bin/bash
CLIENT_IP=$1

source ~/CLIK/config.ini

#Debug script..
echo "Client ${1} random file generate"

echo -n > "${RANDOM_FILE}_${CLIENT_IP}"
for i in {1..20}
do
	echo ${RANDOM} >> "${RANDOM_FILE}_${CLIENT_IP}"
done

