#!/bin/bash
# Description - 
# CLIK daemon가 받은 요청을 기반으로, 응답하는 과정을 수행한다.

# line 29에서 random_file, result_file 전송하는데, 이는 kboard과제에 종속적인 스크립트. 
# (config.ini 구성예정) Assignment_Grading_script 모두 보내주는 형태로 구성하기

CLIENT_IP=$1
ASSIGNMENT_NUMBER=$2

source ~/CLIK/config.ini

EXAM="$(cat ${CLIK_EXAMFILE})"

#~/CLIK/utils/kboard/randomFileGenerate.sh $1
#~/CLIK/utils/kboard/resultFileGenerate.sh $1

RESULT_USER="output_user_${CLIENT_IP}"
RESULT_KERNEL="output_kernel_${CLIENT_IP}"
#CORRECT_USER="correct_user_${CLIENT_IP}"
#CORRECT_KERNEL="correct_kernel_${CLIENT_IP}"

if [ "${EXAM}" -eq 1 ]
then
	#RANDOM_FILE_IP=${RANDOM_FILE}_exam
	RANDOM_NAME=${RANDOM_FILENAME}_exam
else

	#RANDOM_FILE_IP=${RANDOM_FILE}_${CLIENT_IP}
	RANDOM_NAME=${RANDOM_FILENAME}_${CLIENT_IP}
fi

## result파일, random파일, testscript 전송!

scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ${RANDOM_PATH}${RANDOM_NAME} ${ASSIGNMENT_GRADING_SCRIPTS[$2]} ${USER_NAME}@${CLIENT_IP}:~/

ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY} ${USER_NAME}@${CLIENT_IP} /bin/bash -s ${RANDOM_NAME} ${RESULT_USER} ${RESULT_KERNEL} <<'__HERE' 
	./agent.sh res ${1} ${2} ${3}
__HERE

