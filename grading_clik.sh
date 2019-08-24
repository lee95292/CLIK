#!/bin/bash

# Parameter Mapping 1_ targetPath,  2_ tragetName

REMOTE_PREFIX="192.168.0."
SERVER_PORT="18080"
PUBLIC_KEY="~/.ssh/2ndkey" 		#openstack master key로 변경요망.
USER_NAME="ubuntu"
SHELL_PORT=7777

./clib/grading_server &

i=2
while [ ${i} -lt 256 ];
do
	if [ ${i} -eq 120 ]		# os mklee 계정 테스트코드
	then 
		#clik_client 전송
		scp -P ${SHELL_PORT} -i ${PUBLIC_KEY} ./clib/clik_client ./utils/request.sh  ${USER_NAME}@${REMOTE_PREFIX}${i}:~/
		
		#With_ T Option
		if [ "${EXAMINATION}" -eq 1 ] 
		then
			ssh -p ${SHELL_PORT} -i ${PUBLIC_KEY}  ${USER_NAME}@${REMOTE_PREFIX}${i} /bin/bash -s ${GRADE_SCRIPT} <<'__HERE' 
			./request.sh
	
__HERE
		fi
	fi
	((i++))
done


