#!/bin/bash

files=$(find /home/ts008/test -ctime -10 -name "*.txt")
for file in $files
do
	echo "$file"
	#rm "$file"
done
