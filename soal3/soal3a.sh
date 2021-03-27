#!/bin/bash

for ((i=0; i<23; i=i+1))
do
	wget https://loremflickr.com/320/240/kitten -a foto.log
done

echo "x" > dupes.txt
while [ -s dupes.txt ]
do
	rm dupes.txt
	find -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 15 | awk -F/ '{print $2}' > dupes.txt
	if [ -s dupes.txt ] 
	then 
		rm $(grep -m1 "" dupes.txt)
	fi
done
rm dupes.txt

for ((j=1; j<=$(ls -l | awk '{print $NF}' | grep "kitten" | wc -l); j=j+1))
do
	mv $(ls -l | awk '{print $NF}' | grep -m1 "kitten") Koleksi_$j
done
