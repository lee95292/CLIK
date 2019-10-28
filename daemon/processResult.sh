#!/bin/bash
# Description - 
# [CLIK/clib/gradingServer.c] 에서 수행하는 코드.
# 아래 파라미터들 통해 [CLIK/data/*.csv] 파일 생성 또는 기존 파일에 채점 데이터 추가

IPADDR=$1
#CORRECT=$2
HOSTNAME=$2
ASSIGNMENT_NUMBER=$3

source ~/CLIK/config.ini

RESULT_USER="output_user_${IPADDR}"
RESULT_KERNEL="output_kernel_${IPADDR}"

scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ${USER_NAME}@${IPADDR}:~/${RESULT_USER} ~/CLIK/repository/raws/
scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ${USER_NAME}@${IPADDR}:~/${RESULT_KERNEL} ~/CLIK/repository/raws/

RES_USER=$(diff ~/CLIK/repository/raws/${RESULT_USER} ${CORRECT_FILE_USER} -U 0 | grep -v ^@ | tail -n +4 | wc -l)
RES_KERNEL=$(diff ~/CLIK/repository/raws/${RESULT_KERNEL} ${CORRECT_FILE_KERNEL} -U 0 | grep -v ^@ | tail -n +4 | wc -l)

RESULT=Fail

RES_TOTAL=$((RES_USER+RES_KERNEL))

if [ ${RES_TOTAL} -eq 0 ]
then
	RESULT=Pass
fi

echo ${ASSIGNMENT_NAMES[${ASSIGNMENT_NUMBER}]} ${HOSTNAME} ${IPADDR} ${RESULT} $(date +'%T_%m-%d-%Y') DIFF: User ${RES_USER} Kernel ${RES_KERNEL} >> ~/CLIK/repository/${HOSTNAME}.csv

