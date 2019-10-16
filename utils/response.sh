#!/bin/bash
# Description - 
# grading_server가 받은 요청을 기반으로, 응답하는 과정을 수행한다.

# TODO random generating file  kboard/data 로 분리하기
# line 29에서 random_file, result_file 전송하는데, 이는 kboard과제에 종속적인 스크립트. 
# (config.ini 구성예정) Assignment_Grading_script 모두 보내주는 형태로 구성하기

CLIENT_IP=$1
ASSIGNMENT_NUMBER=$2

source ~/CLIK/config.ini

echo -n > "${RANDOM_FILE}"


for i in {0..20}
do
	echo "${RANDOM}" >> "${RANDOM_FILE}"
done

echo \n $(pwd) 

~/CLIK/utils/kboard/resultFileGenerate.sh


## result파일, random파일, testscript 전송!

scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ${RESULT_FILE} ${RANDOM_FILE} ${ASSIGNMENT_GRADING_SCRIPTS[$2]} ${USER_NAME}@${1}:~/

ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY}  ${USER_NAME}@${1} /bin/bash -s ${GRADE_SCRIPT} <<'__HERE' 
	./request.sh res
__HERE

