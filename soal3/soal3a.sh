#!/bin/bash

for ((i=0; i<23; i=i+1))
do
	wget https://loremflickr.com/320/240/kitten -a foto.log
done

find -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 15 | awk -F/ '{print $2}' dupes.txt


