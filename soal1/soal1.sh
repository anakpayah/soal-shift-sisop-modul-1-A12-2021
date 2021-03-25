#!/bin/bash

grep -oP '(?<=ticky: ).*' syslog.log > text.txt
grep -oP '(?<=ERROR ).*(?= \()' syslog.log | sort -u > error1.txt
echo "Connection to DB failed,$(grep "ERROR Connection" syslog.log | wc -l)" >> error.csv
echo "Permission denied while closing ticket,$(grep "ERROR Permission" syslog.log | wc -l)" >> error.csv
echo "The ticket was modified while updating,$(grep "ERROR The" syslog.log | wc -l)" >> error.csv
echo "Ticket doesn't exist,$(grep "ERROR Ticket" syslog.log | wc -l)" >> error.csv
echo "Timeout while retrieving information,$(grep "ERROR Timeout" syslog.log | wc -l)" >> error.csv
echo "Tried to add information to closed ticket,$(grep "ERROR Tried" syslog.log | wc -l)" >> error.csv
echo "$(cat error.csv | sort -t, -k 2 -n -r)" > error_message.csv
rm error.csv

