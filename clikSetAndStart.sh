#!/bin/bash

## parameter mapping ##
TARGET_PATH="~/osAsgn01/a01/"
EXAMINATION=0
GRADING_SERVER=0

function usage {
	echo -e "\n Usage : ${0} [options] Assignment name  \n";
	echo " Options:";
	echo "	-t  Examinate Total grading and capture the result";
	echo "        -s  Start Grading Server"
	echo "	-h  Help(usage)";
}

function printResult {
	if [ $2 -eq 1 ] 
	then
		echo "      $1		-TRUE"
	else
		echo "      $1		-FALSE"
	fi
} 


if [ -z $1 ]
then
	usage;
	exit 1;
fi

PARAM="sht";

while getopts $PARAM opt
do
	case $opt in
		t)
			EXAMINATION=1
			;;
		
		s)
			GRADING_SERVER=1
			;;
		h)
			usage;
			exit 1;
			;;
	esac
done

## grding script의 실행가능여부와 존재여부 체크하는 부분!!! 넣어주기
#test

echo -e "\n setting result : \n"

printResult Student_exmaination  ${EXAMINATION}
printResult Grading_server_start ${GRADING_SERVER}

echo -e "\n"

export EXAMINATION=${EXAMINATION} GRADING_SERVER=${GRADING_SERVER}
./grading_clik.sh

