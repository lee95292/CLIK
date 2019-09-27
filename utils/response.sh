#!/bin/bash
CLIENT_IP=$1
ASSIGNMENT_NUMBER=$2

source ~/CLIK/config.ini

echo -n > "${RANDOM_FILE}"
for i in {0..20}
do
	echo "${RANDOM}" >> "${RANDOM_FILE}"
done

echo \n $(pwd) 

~/CLIK/utils/kboard/generate.sh


## result파일, random파일, testscript 전송!

scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ${RESULT_FILE} ${RANDOM_FILE} ${ASSIGNMENT_GRADING_SCRIPTS[$2]} ${USER_NAME}@${1}:~/

ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY}  ${USER_NAME}@${1} /bin/bash -s ${GRADE_SCRIPT} <<'__HERE' 
	./request.sh res
__HERE

