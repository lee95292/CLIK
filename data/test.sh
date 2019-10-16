#!/bin/bash
# Description -
# For data visualization test
dir=~/CLIK/data

for data in $dir/*.csv
do
	#if [ ${data#*.*} = 'csv' ]
	#then
		 tail -1 $data
	#fi
done
