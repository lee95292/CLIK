#!/bin/bash
# Parameter mapping 1_ IP_Addr
SHELL_PORT="7777"
PUBLIC_KEY="~/.ssh/2ndkey"
USER_NAME="ubuntu"
RANDOM_FILE="random_values"

echo -n > "${RANDOM_FILE}"
for i in {0..20}
do
	echo "${RANDOM}" >> "${RANDOM_FILE}"
done

echo \n $(pwd) 

~/CLIK/utils/generate.sh


## result파일, random파일, testscript 전송!

scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ~/CLIK/utils/result_values ~/CLIK/utils/random_values ~/CLIK/utils/testscript.sh ${USER_NAME}@${1}:~/

ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY}  ${USER_NAME}@${1} /bin/bash -s ${GRADE_SCRIPT} <<'__HERE' 
	~/testscript.sh;echo result $? $(hostname)|nc 192.168.0.7 18081;rm ~/testscript.sh
__HERE

