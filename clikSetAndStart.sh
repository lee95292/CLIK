#!/bin/bash

## parameter mapping ##
source config.ini

TARGET_PATH="~/osAsgn01/a01/"
EXAMINATION=0
GRADING_SERVER=0

function usage {
	echo -e "\n Usage : ${0} [options] Assignment_name  \n";
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

PARAMS=("$@")
ASSIGNMENT_NAME=${PARAMS[$#-1]}
ASSIGNMENT_NUMBER=0
echo AA $ASSIGNMENT_NAME
while [ ${ASSIGNMENT_NAME} != ${ASSIGNMENT_NAMES[${ASSIGNMENT_NUMBER}]} ]
do
	(($ASSIGNMENT_NUMBER+1))
	if [ ${ASSIGNMENT_NUMBER} > ${#ASSIGNMENT_NAMES[@]} ]
	then
		echo "!!!!! invalid assignment name (Check config.ini)!!!!!"
		exit 1;
	fi
done

sed -i "2s/.*/ASSIGNMENT_NUMBER=${ASSIGNMENT_NUMBER}/g" ${REQUEST_FILE}

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
echo  Assignment_name 		${ASSIGNMENT_NAME}

echo -e "\n"

export EXAMINATION=${EXAMINATION} GRADING_SERVER=${GRADING_SERVER} ASSIGNMENT_NUMBER=${ASSIGNMENT_NUMBER}
./grading_clik.sh 

