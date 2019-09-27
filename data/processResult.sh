#!/bin/bash
IPADDR=$1
CORRECT=$2
HOSTNAME=$3
ASSIGNMENT_NUMBER=$4

source ~/CLIK/config.ini

RESULT=Fail

if [ $2 > 10 ]
then
	RESULT=Pass
fi

echo ${ASSIGNMENT_NAMES[$4]} 201716422 $1 $2 ${RESULT} $(date +'%T_%m-%d-%Y') >> ~/CLIK/data/$3.csv

