#!/bin/bash
# Description -
# CLIK/repository/*.csv 파일 아래 포멧으로 시각화 시각화  

#echo "Default Format"
#echo "+------------------+-------------+---------------+-----------+-----------+---------------------+"
#echo "|    Assignment    | Student ID  | Instance IP   | Result    | Pass/Fail | Time                |"
#echo "+------------------+---------------+---------------+---------+-----------+---------------------+"
#echo "| Kernal Clipboard | 201592984   | 192.168.0.252 | (200/204) | Pass      | 04:49:24 09-18-2019 |"
#echo "+------------------+-------------+---------------+-----------+-----------+---------------------+"


function divisionLine {
	echo  "+----------------+-------------+--------------+-----------+---------------------+-------------------------------+"
}

function header {
	divisionLine;
	echo "|   Assignment   |  Student ID |  Instance IP | Pass/Fail |        Time         |            Detail             |"
	divisionLine;
}
function formatLine() {
	printf "|%15s | %11s | %12s | %9s | %19s |" $1 $2 $3 $4 $5
	#divisionLine;
}

CSV_FILES=~/CLIK/repository

echo -e "\n"
header;
for data in $CSV_FILES/*.csv
do
	formatLine `tail -1 $data`
	#echo "`tail -1 $data | awk '{$1="";$2="";$3="";$4="";$5=""; print $0;}'` |"
	printf "%30s |\n" "`tail -1 $data | awk '{$1="";$2="";$3="";$4="";$5=""; print $0;}'`" 
	#printf "%20s |\n" `tail -1 $data | awk '{$1="";$2="";$3="";$4="";$5=""; print $0;}'`
	#divisionLine;
done

divisionLine;

echo -e "\n"
