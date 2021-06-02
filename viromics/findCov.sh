#!/bin/bash

##Script to calculate coverage, find positions with increased read depth & group those into regions

##Depencies:
##		samtoolsV1_11Env in conda

##Parameters:
##		1: path to sorted bam file (IN)
##		2: path to coverage file (OUT)
##		3: path to file containing positions with increased read depth (OUT)
##		4: path to file containing regions with increased read depth (OUT)
##		5: path to file containing some info on inputfile, genome coverage & location to and interpretation of outputfiles (OUT)

##Extract read depth info
samtools depth -aa $1 > tempCov.txt

##Extract reads with with above average read depth
reads=$(awk '{sum+=$3} END {print sum}' tempCov.txt)
numTo=$(wc -l tempCov.txt | awk '{print $1}')
avgInt=$(expr $(( reads  / numTo)))
avgFl=$(awk -v r=$reads -v t=$numTo 'BEGIN{print r / t}')
awk -v x=$avgInt '$3 > x' tempCov.txt > hiCov.txt

##Calculate percentage of genome above treshold
numHi=$(wc -l hiCov.txt | awk '{print $1}')
per=$(awk -v h=$numHi -v t=$numTo 'BEGIN{print h*100 / t}')
##Add fold change to high read depth positions
awk -v x=$avgFl '{print $3/x}' hiCov.txt > fold
paste hiCov.txt fold > $3

##Extract high read depth regions
	##split file to a file per chromosome/contig
mkdir temp
awk -F '\t' '{ fname = "temp/"$1".txt"; print >>fname; close(fname) }' hiCov.txt
	##go from position to region
for file in temp/*
do
	awk '
    		function output() { print $1"\t"start (prev == start ? "" : "\t"prev) }
    		NR == 1 {start = prev = $2; next}
    		$2 > prev+1 {output(); start = $2}
    		{prev = $2}
    		END {output()}
	' < $file >> $4
done

##Writing log file
echo "Information regarding the coverage calculated on input file: " $1 >> $5
echo "" >> $5
echo "Average read depth across genome (float): " $avgFl >> $5
echo "Average read depth across genome (int - treshold value for inclusion): " $(expr $(( reads  / numTo))) >> $5
echo "" >> $5
echo "Percentage of genome with increased read depth: " $per >> $5
echo "" >> $5
echo "Path to file with read depth (=output of samtools depth cmd):  " $2 >> $5
echo "Path to file with positions with increased read depth (format: CONTIG - POS - DEPTH - FOLD INCREASE): " $3 >> $5
echo "Path to file with grouped regions with increased read depth (format: CONTIG - START - STOP): " $4 >> $5

##Making sure only files desired with correct names are retained
mv tempCov.txt $2

rm fold
rm -rf temp
rm hiCov.txt
