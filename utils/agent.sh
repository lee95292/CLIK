#CLIK Agent running on Student Instnace
ASSIGNMENT_NUMBER=0
CLIK_ADDR="192.168.0.254"
PORT="18081"
if [ $1 = 'req' ] # for request
then	
	ASSIGNMENT_NUMBER=$2
	echo test!!
	echo request $(hostname) ${ASSIGNMENT_NUMBER} |nc ${CLIK_ADDR} ${PORT}
elif [ $1 = 'res' ] #for result
then
	~/testscript.sh $2 $3 $4
	echo result $(hostname) ${ASSIGNMENT_NUMBER}|nc ${CLIK_ADDR} ${PORT}
	rm $2 $3 $4
	rm ~/testscript.sh
fi
