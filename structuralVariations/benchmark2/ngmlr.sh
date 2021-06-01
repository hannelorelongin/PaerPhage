#! /bin/bash

ngmlr -t 16 -r ../genomes/PaLo3.fasta -q ../nanopore/PaLo4.trim.fastq.gz -o g03r04.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo4.fasta -q ../nanopore/PaLo3.trim.fastq.gz -o g04r03.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo9.fasta -q ../nanopore/PaLo8.trim.fastq.gz -o g09r08.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo11.fasta -q ../nanopore/PaLo12.trim.fastq.gz -o g11r12.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo30.fasta -q ../nanopore/PaLo34.trim.fastq.gz -o g30r34.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo32.fasta -q ../nanopore/PaLo33.trim.fastq.gz -o g32r33.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo33.fasta -q ../nanopore/PaLo32.trim.fastq.gz -o g33r32.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo38.fasta -q ../nanopore/PaLo45.trim.fastq.gz -o g38r45.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo39.fasta -q ../nanopore/PaLo44.trim.fastq.gz -o g39r44.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo44.fasta -q ../nanopore/PaLo39.trim.fastq.gz -o g44r39.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo40.fasta -q ../nanopore/PaLo47.trim.fastq.gz -o g40r47.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo46.fasta -q ../nanopore/PaLo41.trim.fastq.gz -o g46r41.sam -x ont
ngmlr -t 16 -r ../genomes/PaLo43.fasta -q ../nanopore/PaLo42.trim.fastq.gz -o g43r42.sam -x ont
