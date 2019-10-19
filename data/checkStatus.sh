#!/bin/bash
# Description -
# CLIK/data/*.csv 파일 아래 포멧으로 시각화 시각화  

#echo "Default Format"
#echo "+------------------+-------------+---------------+-----------+-----------+---------------------+"
#echo "|    Assignment    | Student ID  | Instance IP   | Result    | Pass/Fail | Time                |"
#echo "+------------------+---------------+---------------+---------+-----------+---------------------+"
#echo "| Kernal Clipboard | 201592984   | 192.168.0.252 | (200/204) | Pass      | 04:49:24 09-18-2019 |"
#echo "+------------------+-------------+---------------+-----------+-----------+---------------------+"


function divisionLine {
	echo  "+------------------+-----------------+----------------+------------+-----------+---------------------+"
}

function header {
	divisionLine;
	echo "|    Assignment    |   Student ID    |  Instance IP   |  Result    | Pass/Fail | Time                |"
	divisionLine;
}
function formatLine() {
	printf "|%17s |%16s | %13s  | %10s | %9s | %19s |\n" $1 $2 $3 $4 $5 $6
	divisionLine;
}

CSV_FILES=~/CLIK/data

echo -e "\n"
header;
for data in $CSV_FILES/*.csv
do
	formatLine `tail -1 $data`
done

echo -e "\n"
