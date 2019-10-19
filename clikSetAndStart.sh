#!/bin/bash
## parameter mapping ##
source config.ini

TARGET_PATH="~/osAsgn01/a01/"
EXAMINATION=0
RUN_BACKGROUND=0

function usage {
	echo -e "\n Usage : ${0} [options] Assignment_name  \n";
	echo " Options:";
	echo "	-t  Examinate Total grading and capture the result";
	echo "	-b  Background judge";
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

PARAM="bsht";
while getopts $PARAM opt
do
	case $opt in
		t)
			EXAMINATION=1
			;;
		b)
			RUN_BACKGROUND=1
			;;
		h)
			usage;
			exit 1;
			;;
	esac
done

PARAMS=("$@")
ASSIGNMENT_NAME=${PARAMS[$#-1]}
ASSIGNMENT_NUMBER=0
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



## grding script의 실행가능여부와 존재여부 체크하는 부분!!! 넣어주기
#test

echo -e "\n setting result : \n"

printResult Student_exmaination  ${EXAMINATION}
printResult RUN_BACKGROUND ${RUN_BACKGROUND}
echo  Assignment_name 		${ASSIGNMENT_NAME}

echo -e "\n"

export EXAMINATION=${EXAMINATION} ASSIGNMENT_NUMBER=${ASSIGNMENT_NUMBER}

i=2
while [ ${i} -le ${NETWORK_RANGE} ];
do
	
	if [ "${RUN_BACKGROUND}" -eq 1 ]
	then
		nohup ./grading_clik.sh ${i}  #> ~/CLIK/log/clikLog_$(date +'%T_%m-%d-%Y').log
	else
		./grading_clik.sh ${i}
	fi

	((i++))
done




