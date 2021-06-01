#!/bin/bash

##Making sure we can invoke conda environments 
source ~/miniconda3/etc/profile.d/conda.sh

##Step 1: aligning reads to genome of origin
conda activate bwaEnv
	##For SVs patient 1: were found present in PaLo3 --> align to PaLo3
bwa index /mnt/data/data_variantAnalysis/genomes/PaLo3.fasta
bwa mem -t 12 /mnt/data/data_variantAnalysis/genomes/PaLo3.fasta /mnt/data/data_variantAnalysis/viromics/viralReads_10pt/SVspt1R1.fq /mnt/data/data_variantAnalysis/viromics/viralReads_10pt/SVspt1R2.fq > SVp1_PaLo3.sam
	##For SV patient 3: were found present in PaLo11 --> align to PaLo11
bwa index /mnt/data/data_variantAnalysis/genomes/PaLo11.fasta
bwa mem -t 12 /mnt/data/data_variantAnalysis/genomes/PaLo11.fasta /mnt/data/data_variantAnalysis/viromics/viralReads_10pt/SV7pt3R1.fq /mnt/data/data_variantAnalysis/viromics/viralReads_10pt/SV7pt3R1.fq > SVp3_PaLo11.sam
	##For SVs patient 8: were found present in PaLo40 --> align to PaLo40
bwa index /mnt/data/data_variantAnalysis/genomes/PaLo40.fasta
bwa mem -t 12 /mnt/data/data_variantAnalysis/genomes/PaLo40.fasta /mnt/data/data_variantAnalysis/viromics/viralReads_10pt/SV10pt8R1.fq /mnt/data/data_variantAnalysis/viromics/viralReads_10pt/SV10pt8R1.fq > SVp8_PaLo40.sam
conda deactivate

##Step 2: SAM to BAM
conda activate samtoolsV1_11Env
	##SVs patient 1
samtools view -S -b SVp1_PaLo3.sam > SVp1_PaLo3.bam
samtools sort SVp1_PaLo3.bam -o SVp1_PaLo3.sorted.bam
samtools index SVp1_PaLo3.sorted.bam
	##SVs patient 3
samtools view -S -b SVp3_PaLo11.sam > SVp3_PaLo11.bam
samtools sort SVp3_PaLo11.bam -o SVp3_PaLo11.sorted.bam
samtools index SVp3_PaLo11.sorted.bam
	##SVs patient 8
samtools view -S -b SVp8_PaLo40.sam > SVp8_PaLo40.bam
samtools sort SVp8_PaLo40.bam -o SVp8_PaLo40.sorted.bam
samtools index SVp8_PaLo40.sorted.bam

##Step 3: calculating coverage statistics
samtools coverage SVp1_PaLo3.sorted.bam -o SVp1_PaLo3.coverage
samtools coverage SVp3_PaLo11.sorted.bam -o SVp3_PaLo11.coverage
samtools coverage SVp8_PaLo40.sorted.bam -o SVp8_PaLo40.coverage
conda deactivate
