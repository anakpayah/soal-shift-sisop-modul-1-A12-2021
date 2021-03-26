#!/bin/bash

grep -oP '(?<=ticky: ).*' syslog.log > text.txt
grep -oP '(?<=ERROR ).*(?= \()' syslog.log | sort -u > temp1.txt
n=$(cat temp1.txt | wc -l)/2
for ((i=0; i<n; i=i+1))
do
	echo "$(grep -m1 "" temp1.txt),$(grep "$(grep -m1 "" temp1.txt)" syslog.log | wc -l)" >> error.txt
	grep -v "$(grep -m1 "" temp1.txt)" temp1.txt > temp2.txt
	> temp1.txt
	echo "$(grep -m1 "" temp2.txt),$(grep "$(grep -m1 "" temp2.txt)" syslog.log | wc -l)" >> error.txt
	grep -v "$(grep -m1 "" temp2.txt)" temp2.txt > temp1.txt
	> temp2.txt
done
echo "$(cat error.txt | sort -t, -k 2 -n -r)" > error_message.csv
rm temp1.txt
rm temp2.txt
rm error.txt


