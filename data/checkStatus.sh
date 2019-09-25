#!/bin/bash

echo "Default Format"
echo "+------------------+-------------+---------------+-----------+-----------+---------------------+"
echo "|    Assignment    | Student ID  | Instance IP   | Result    | Pass/Fail | Time                |"
echo "+------------------+---------------+---------------+---------+-----------+---------------------+"
echo "| Kernal Clipboard | 201592984   | 192.168.0.252 | (200/204) | Pass      | 04:49:24 09-18-2019 |"
echo "+------------------+-------------+---------------+-----------+-----------+---------------------+"


function divisionLine {
	echo "+------------------+-------------+---------------+-----------+-----------+---------------------+"
}

function header {
	divisionLine;
	echo "|    Assignment    | Student ID  | Instance IP   | Result    | Pass/Fail | Time                |"
	divisionLine;
}
function formatLine() {
	printf "|%18s|%12s | %13s | %9s | %9s | %19s |\n" $1 $2 $3 $4 $5 $6
	divisionLine;
}
header;
formatLine 00 11 22 33 44444 $(date +"%T-%m-%d-%Y")
