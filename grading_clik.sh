#!/bin/bash
source ~/CLIK/config.ini

if [ "${GRADING_SERVER} -eq 1" ]
then
	echo -----server start-----
	./clib/grading_server &
fi

i=2
while [ ${i} -le ${NETWORK_RANGE} ];
do
	echo ---checking ${CLIENT_REMOTE_PREFIX}${i}----
	# 쉘 체크: 활성화된 계정인지 체크
	nc -z -w 1 ${CLIENT_REMOTE_PREFIX}${i} ${SHELL_PORT} 
	if [ $? -eq 0 ]		
	then 
		#clik_client 전송
		scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ${REQUEST_FILE} ${USER_NAME}@${CLIENT_REMOTE_PREFIX}${i}:~/
		
		#With_ T Option
		if [ "${EXAMINATION}" -eq 1 ] 
		then
			ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY} -o "StrictHostKeyChecking = no" ${USER_NAME}@${CLIENT_REMOTE_PREFIX}${i} /bin/bash -s ${GRADE_SCRIPT} <<'__HERE'
		./request.sh req
__HERE
		fi
	fi
	((i++))
done


