#!/bin/bash

######################################
## Extracting mobile prophage reads ##
######################################
## 1: align reads to SV             ##
## 2: extract mapped reads          ##
## 3: get fastq output              ##
######################################

##making conda available for subshell
source ~/miniconda3/etc/profile.d/conda.sh

######################################
## 1: align reads to SV             ##
######################################

##aligning reads of genome of specific bacterial isolate to a mobile prophage found within that isolate
conda activate bwaEnv
##SV10 of pt8: identified as Pseudo_phi297
bwa index ../potentialProphages_SV/pt8_PaLo40_47/phageBLASTpt8.fa
bwa mem -t 12 ../potentialProphages_SV/pt8_PaLo40_47/phageBLASTpt8.fa ../illumina/PaLo40/PaLo40R1.fastq.gz  ../illumina/PaLo40/PaLo40R2.fastq.gz > readsPaLo40onSV10pt8.sam
##SV7 of pt3: identified as Pseudo_phiCTX
bwa index ../potentialProphages_SV/pt3_PaLo11_12/phageBLASTpt3.fa
bwa mem -t 12 ../potentialProphages_SV/pt3_PaLo11_12/phageBLASTpt3.fa ../illumina/PaLo11/PaLo11R1.fastq.gz  ../illumina/PaLo11/PaLo11R2.fastq.gz > readsPaLo11onSV7pt3.sam
##SVs of pt1: identified as 
bwa index ../potentialProphages_SV/pt1_PaLo3_4/SVspt1.fa
bwa mem -t 12 ../potentialProphages_SV/pt1_PaLo3_4/SVspt1.fa ../illumina/PaLo3/PaLo3R1.fastq.gz  ../illumina/PaLo3/PaLo3R2.fastq.gz > readsPaLo3onSVspt1.sam
conda deactivate 

######################################
## 2: extract mapped reads          ##
######################################

conda activate samtoolsEnv
samtools view -b -F 4 readsPaLo40onSV10pt8.sam > alignedOnly_rPaLo40onSV10pt8.bam
samtools view -b -F 4 readsPaLo11onSV7pt3.sam > alignedOnly_rPaLo11onSV7pt3.bam
samtools view -b -F 4 readsPaLo3onSVspt1.sam > alignedOnly_rPaLo3onSVspt1.bam
samtools sort -n alignedOnly_rPaLo40onSV10pt8.bam -o alignedOnly_rPaLo40onSV10pt8.qsort.bam
samtools sort -n alignedonly_rPalo11onSV7pt3.bam -o alignedonly_rPalo11onSV7pt3.qsort.bam
samtools sort -n alignedOnly_rPaLo3onSVspt1.bam -o alignedOnly_rPaLo3onSVspt1.qsort.bam
conda deactivate

######################################
## 3: get fastq output              ##
######################################

conda activate bedtoolsEnv
bedtools bamtofastq -i alignedOnly_rPaLo40onSV10pt8.qsort.bam -fq SV10pt8R1.fq -fq2 SV10pt8R2.fq
bedtools bamtofastq -i alignedOnly_rPaLo11onSV7pt3.qsort.bam -fq SV7pt3R1.fq -fq2 SV7pt3R2.fq
bedtools bamtofastq -i alignedOnly_rPaLo3onSVspt1.qsort.bam -fq SVspt1R1.fq -fq2 SVspt1R2.fq
conda deactivate 

##cleaning out environment
rm *.bam
rm *.sam
rm ../potentialProphages_SV/*/*.fa.*
