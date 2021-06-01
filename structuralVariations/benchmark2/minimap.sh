#! /bin/bash

minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo3.fasta ../../nanopore/PaLo4.trim.fastq.gz > g03r04.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo4.fasta ../../nanopore/PaLo3.trim.fastq.gz > g04r03.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo9.fasta ../../nanopore/PaLo8.trim.fastq.gz > g09r08.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo11.fasta ../../nanopore/PaLo12.trim.fastq.gz > g11r12.sam 
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo30.fasta ../../nanopore/PaLo34.trim.fastq.gz > g30r34.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo32.fasta ../../nanopore/PaLo33.trim.fastq.gz > g32r33.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo33.fasta ../../nanopore/PaLo32.trim.fastq.gz > g33r32.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo38.fasta ../../nanopore/PaLo45.trim.fastq.gz > g38r45.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo39.fasta ../../nanopore/PaLo44.trim.fastq.gz > g39r44.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo44.fasta ../../nanopore/PaLo39.trim.fastq.gz > g44r39.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo40.fasta ../../nanopore/PaLo47.trim.fastq.gz > g40r47.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo46.fasta ../../nanopore/PaLo41.trim.fastq.gz > g46r41.sam
minimap2 --MD -ax map-ont -t 16 ../../genomes/PaLo43.fasta ../../nanopore/PaLo42.trim.fastq.gz > g43r42.sam

