#! /bin/bash

snippy --cpus 8 --reference ../prokka/PaLo3/PaLo3.gbk --R1 ../illumina/PaLo4/PaLo4R1.fastq.gz --R2 ../illumina/PaLo4/PaLo4R2.fastq.gz --outdir g03r04
snippy --cpus 8 --reference ../prokka/PaLo4/PaLo4.gbk --R1 ../illumina/PaLo3/PaLo3R1.fastq.gz --R2 ../illumina/PaLo3/PaLo3R2.fastq.gz --outdir g04r03
snippy --cpus 8 --reference ../prokka/PaLo9/PaLo9.gbk --R1 ../illumina/PaLo8/PaLo8R1.fastq.gz --R2 ../illumina/PaLo8/PaLo8R2.fastq.gz --outdir g09r08
snippy --cpus 8 --reference ../prokka/PaLo11/PaLo11.gbk --R1 ../illumina/PaLo12/PaLo12R1.fastq.gz --R2 ../illumina/PaLo12/PaLo12R2.fastq.gz --outdir g11r12
snippy --cpus 8 --reference ../prokka/PaLo30/PaLo30.gbk --R1 ../illumina/PaLo34/PaLo34R1.fastq.gz --R2 ../illumina/PaLo34/PaLo34R2.fastq.gz --outdir g30r34
snippy --cpus 8 --reference ../prokka/PaLo32/PaLo32.gbk --R1 ../illumina/PaLo33/PaLo33R1.fastq.gz --R2 ../illumina/PaLo33/PaLo33R2.fastq.gz --outdir g32r33
snippy --cpus 8 --reference ../prokka/PaLo33/PaLo33.gbk --R1 ../illumina/PaLo32/PaLo32R1.fastq.gz --R2 ../illumina/PaLo32/PaLo32R2.fastq.gz --outdir g33r32
snippy --cpus 8 --reference ../prokka/PaLo38/PaLo38.gbk --R1 ../illumina/PaLo45/PaLo45R1.fastq.gz --R2 ../illumina/PaLo45/PaLo45R2.fastq.gz --outdir g38r45
snippy --cpus 8 --reference ../prokka/PaLo39/PaLo39.gbk --R1 ../illumina/PaLo44/PaLo44R1.fastq.gz --R2 ../illumina/PaLo44/PaLo44R2.fastq.gz --outdir g39r44
snippy --cpus 8 --reference ../prokka/PaLo44/PaLo44.gbk --R1 ../illumina/PaLo39/PaLo39R1.fastq.gz --R2 ../illumina/PaLo39/PaLo39R2.fastq.gz --outdir g44r39
snippy --cpus 8 --reference ../prokka/PaLo40/PaLo40.gbk --R1 ../illumina/PaLo47/PaLo47R1.fastq.gz --R2 ../illumina/PaLo47/PaLo47R2.fastq.gz --outdir g40r47
snippy --cpus 8 --reference ../prokka/PaLo46/PaLo46.gbk --R1 ../illumina/PaLo41/PaLo41R1.fastq.gz --R2 ../illumina/PaLo41/PaLo41R2.fastq.gz --outdir g46r41
snippy --cpus 8 --reference ../prokka/PaLo43/PaLo43.gbk --R1 ../illumina/PaLo42/PaLo42R1.fastq.gz --R2 ../illumina/PaLo42/PaLo42R2.fastq.gz --outdir g43r42
