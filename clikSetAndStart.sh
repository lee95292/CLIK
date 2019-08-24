#!/bin/bash

# TODO: 안쓰는 파라미터 정리하기. (3,4번 파라미터)

## parameter mapping ##
function usage {
	echo "Usage : ${0} [options] gradingFile  ";
	echo "Options:";
	echo "	-d  <path(string)> TARGET DERECTORY PATH";
	echo "	-n  <name(string)> TARGET MAME";
	echo "	-t  Examinate Total grading and capture the result";
	echo "	-h  Help(usage)";
}

if [ -z ${1} ]
then 
	usage;
	exit 1;
fi

TARGET_PATH="~/osAsgn01/a01/"
TARGET_NAME="copy"
EXAMINATION=0
PARAM="d:n:ht";

while getopts $PARAM opt
do
	case $opt in
		d)
			TARGET_PATH=$OPTARG
			;;
		n)
			TARGET_NAME=$OPTARG
			;;
		t)
			EXAMINATION=1
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
echo  ${NUM_PARAM}
echo "setting result - "
echo "  TARGET DERECTORY PATH - ${TARGET_PATH}"
echo "  TARGET NAME 	    - ${TARGET_NAME}"
echo "  GRADING SCRIPT	    - ${args[$NUM_PARAM]}"
if [ ${EXAMINATION} -eq 1 ]
then 
	echo "  EXAMINATION	    - TRUE"
else
	echo "  EXAMINATION	    - FALSE"
fi


export TARGET_PATH=${TARGET_PATH}
export TARGET_NAME=${TARGET_NAME}
export GRADE_SCRIPT=${args[$NUM_PARAM]}
export EXAMINATION=${EXAMINATION}
./grading_clik.sh

