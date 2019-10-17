#!/bin/bash
# Description -
# response.sh를 통해 클라이언트 사이드에서 채점을 수행하는 스크립트

RESULT_FILE="result_values_$(hostname -I)"
RANDOM_FILE="random_values_$(hostname -I)"

correct=0;

input=($(cat ${RANDOM_FILE}))
count=${#RANDOM_FILE[*]}

result=($(cat ${RESULT_FILE}))
rescount=${#RESULT_FILE[*]}
./paste;./paste;./paste;./paste;./paste


for ((i=0;i<6;i++))
do
	./copy ${input[${i}]}
	if [ $? = "${result[${rescount}]}" ] 
	then
		((correct++))
	fi
	((rescount++))	
done
for ((i=0;i<7;i++))
do
	./paste ${input[${i}]}
	if [ $? = "${result[${rescount}]}" ] 
	then
		((correct++))
	fi
	((rescount++))	
done

for ((i=0;i<13;i++))
do
	./copy ${input[${i}]}
	if [ $? = "${result[${rescount}]}" ] 
	then
		((correct++))
	fi
	((rescount++))	
done

./copy -1
if [ $? = "${result[${rescount}]}" ] 
then
	((correct++))
fi
((rescount++))

echo ${correct} / ${rescount}
exit ${correct}

