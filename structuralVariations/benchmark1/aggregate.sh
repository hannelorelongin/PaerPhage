#!/bin/bash

for z in ./*/
do
	if [ -d $z ] 
	then
		cd $z
		genome=$(pwd | cut -d '/' -f6)
		for y in ./*/
		do	
			cd $y
			tool=$(pwd | cut -d '/' -f7)
			for x in ./*.sam
			do
				samtools stats --threads 12 $x | grep '^SN' > stats.txt
				mapq=$(samtools view $x | awk '{sum+=$5} END {print sum/NR}')
				mapped=$(cat stats.txt | grep 'reads mapped:' | cut -f 3)
				total=$(cat stats.txt | grep 'total sequences:' | cut -f 3)
				permap=$mapped/$total
				err=$(cat stats.txt | grep 'error rate:' | cut -f 3)
				echo "$genome $tool $mapq $permap $err"
				rm stats.txt
			done
			cd ..
		done
		cd ..
	fi
done > MapAlignStats.txt
