#!/bin/bash
ASSIGNMENT_NUMBER=0
CLIK_ADDR="192.168.0.254"
PORT="18081"
if [ $1 = 'req' ] # for request
then
	echo test!!
	echo request $(hostname) ${ASSIGNMENT_NUMBER} |nc ${CLIK_ADDR} ${PORT}
elif [ $1 = 'res' ] #for result
then
	~/testscript.sh
	echo result $? $(hostname) ${ASSIGNMENT_NUMBER}|nc ${CLIK_ADDR} ${PORT}
	rm ~/testscript.sh
fi
