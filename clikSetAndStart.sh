#!/bin/bash

# TODO: 안쓰는 파라미터 정리하기. (3,4번 파라미터)

## parameter mapping ##
function usage {
	echo "Usage : ${0} [options] gradingFile  ";
	echo "Options:";
	echo "	-t  Examinate Total grading and capture the result";
	echo "  -s  Start Grading Server"
	echo "	-h  Help(usage)";
}

TARGET_PATH="~/osAsgn01/a01/"
TARGET_NAME="copy"
EXAMINATION=0
GRADING_SERVER=0

PARAM="ght";

while getopts $PARAM opt
do
	case $opt in
		t)
			EXAMINATION=1
			;;
		
		g)
			GRADING_SERVER=1
			;;
		h)
			usage;
			exit 1;
			;;
	esac
done

## grding script의 실행가능여부와 존재여부 체크하는 부분!!! 넣어주기
args=("$@")
NUM_PARAM=${#}
((NUM_PARAM--))
echo "setting result - "
if [ ${EXAMINATION} -eq 1 ]
then 
	echo "  EXAMINATION	    - TRUE"
else
	echo "  EXAMINATION	    - FALSE"
fi


export EXAMINATION=${EXAMINATION} GRADING_SERVER=${GRADING_SERVER}
./grading_clik.sh 16

