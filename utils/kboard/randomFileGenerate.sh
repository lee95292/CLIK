#!/bin/bash
CLIENT_IP=$1

source ~/CLIK/config.ini


echo -n > "${RANDOM_FILE}_${CLIENT_IP}"
for i in {0..20}
do
	echo ${RANDOM} >> "${RANDOM_FILE}_${CLIENT_IP}"
done

