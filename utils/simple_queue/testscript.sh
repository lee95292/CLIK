#!/bin/bash
# Description -
# response.sh를 통해 클라이언트 사이드에서 채점을 수행하는 스크립트

# argument $1 random file
# argument $2 user output
# argument $3 kernel output
#RESULT_USER="output_user_$(hostname -I)"
#RESULT_KERNEL="output_kernel_$(hostname -I)"
#RANDOM_FILE="random_values_$(hostname -I)"

input=($(cat ${1}))

rm ${2} ${3}

#initialization
for ((i=0;i<5;i++))
do
	./paste; > /dev/null
done
sudo dmesg -c

#test
for ((i=0;i<6;i++))
do
	./copy ${input[${i}]} >> ${2}
done

for ((;i<12;i++))
do
	./paste	>> $2
done

for ((;i<1000;i++))
do
	./copy ${input[${i}]} >> ${2}
	./paste >> ${2}	
done

./copy -1 >> ${2}

sudo dmesg -c > ${3}
