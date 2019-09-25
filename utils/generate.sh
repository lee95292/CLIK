#!/bin/bash 
source ~/CLIK/config.ini

input=()
start=0		# 실행간 구분용
count=0		# input배열의 크기


## result파일 초기화
echo -n > "${RESULT_FILE}"

##input random으로 초기화
cat "${RANDOM_FILE}" | while read line
do
	input+=${line}
	((count++))
done

./paste;./paste;./paste;./paste;./paste

for ((i=0;i<6;i++))
do
	./copy ${input[${i}]}
	echo $? >> "${RESULT_FILE}"
	((start++))
done

for((i=0;i<7;i++))
do
	./paste
	echo $? >> "${RESULT_FILE}"
	((start++))
done

for ((i=6;i<13;i++))
do
	./copy ${input[${i}]}
	echo $? >> "${RESULT_FILE}"
	((start++))
done

./copy -1
echo $? >> "${RESULT_FILE}"
((start++))

correct=0
for((i=0;i<${start};i++))
do
	if [ ${answer[${i}]} -eq ${result[${i}]} ]
       	then 
		((correct++)) 
	fi
done

echo ""
echo "----result ${correct} / ${start}----"


exit ${correct}
