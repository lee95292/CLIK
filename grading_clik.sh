#!/bin/bash
source ~/CLIK/config.ini

echo ---checking ${CLIENT_REMOTE_PREFIX}${1}----
	
# 쉘 체크: 활성화된 계정인지 체크
nc -z -w 1 ${CLIENT_REMOTE_PREFIX}${1} ${SHELL_PORT} 
if [ $? -eq 0 ]		
then 
	#clik_client 전송
	scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ${REQUEST_FILE} ${USER_NAME}@${CLIENT_REMOTE_PREFIX}${1}:~/
	
	#With_ T Option
	if [ "${EXAMINATION}" -eq 1 ] 
	then
		date
		ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY} -o "StrictHostKeyChecking = no" ${USER_NAME}@${CLIENT_REMOTE_PREFIX}${1} /bin/bash -s ${ASSIGNMENT_NUMBER} <<'__HERE'
	./agent.sh req ${1}
__HERE
		date
		echo "CLIK Daemon: test script ends in Client"
	fi
fi
