#!/bin/bash 
# Description - 
# 서버에서 정답 표본을 생성한다. 
# Response.sh에 의해 생성된 RandomFile의 난수를 입력으로 하여 정답 표본을 생성한다.

# TODO : kboard/Data 폴더에 random,result  IP별로 분류하는 로직 (For 병렬처리..)
# TODO : (생각해보기) Testscript와 동일화 // 과제 하나당 생성할 스크립트가 너무 많음
CLIENT_IP=$1

source ~/CLIK/config.ini

input=()
start=0		# 실행간 구분용
count=0		# input배열의 크기


## result파일 초기화
echo -n > "${RESULT_FILE}_${CLIENT_IP}"

##input random으로 초기화
 while read line
do
	input[${count}]=${line}
	((count++))
done < "${RANDOM_FILE}_${CLIENT_IP}"
./paste; ./paste ; ./paste ; ./paste ; ./paste;

for ((i=0;i<6;i++))
do
	./copy ${input[${i}]}
	echo $? >> "${RESULT_FILE}_${CLIENT_IP}"
	((start++))
done

for((i=0;i<7;i++))
do
	./paste
	echo $? >> "${RESULT_FILE}_${CLIENT_IP}"
	((start++))
done

for ((i=6;i<13;i++))
do
	./copy ${input[${i}]}
	echo $? >> "${RESULT_FILE}_${CLIENT_IP}"
	((start++))
done

./copy -1
echo $? >> "${RESULT_FILE}_${CLIENT_IP}"
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
