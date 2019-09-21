#!/bin/bash

# Parameter Mapping 1_ targetPath,  2_ tragetName

REMOTE_PREFIX="192.168.0."
SERVER_PORT="18080"
PUBLIC_KEY="~/.ssh/2ndkey" 		#openstack master key로 변경요망.
USER_NAME="ubuntu"
SHELL_PORT=7777
RANGE=$1

if [ "${GRADING_SERVER} -eq 1" ]
then
	./clib/grading_server &
fi

i=2
while [ ${i} -le $RANGE ];
#while [ ${i} -lt 256 ];
do
	echo ---checking ${REMOTE_PREFIX}${i}----
	# 쉘 체크: 활성화된 계정인지 체크
	nc -z -w 1 ${REMOTE_PREFIX}${i} ${SHELL_PORT} 
	if [ $? -eq 0 ]		
	then 
		#clik_client 전송
		scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ./utils/request.sh  ${USER_NAME}@${REMOTE_PREFIX}${i}:~/
		
		#With_ T Option
		if [ "${EXAMINATION}" -eq 1 ] 
		then
			ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY} -o "StrictHostKeyChecking = no" ${USER_NAME}@${REMOTE_PREFIX}${i} /bin/bash -s ${GRADE_SCRIPT} <<'__HERE'
		./request.sh
__HERE
		fi
	fi
	((i++))
done


