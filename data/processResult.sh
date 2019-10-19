#!/bin/bash
# Description - 
# [CLIK/clib/gradingServer.c] 에서 수행하는 코드.
# 아래 파라미터들 통해 [CLIK/data/*.csv] 파일 생성 또는 기존 파일에 채점 데이터 추가

IPADDR=$1
CORRECT=$2
HOSTNAME=$3
ASSIGNMENT_NUMBER=$4

source ~/CLIK/config.ini

RESULT=Fail

if [ $2 -ge 10 ]
then
	RESULT=Pass
fi

echo ${ASSIGNMENT_NAMES[$4]} $3 $1 $2 ${RESULT} $(date +'%T_%m-%d-%Y') >> ~/CLIK/data/$3.csv

