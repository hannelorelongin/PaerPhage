# Initial exploration with reads from mobile prophages

This folder contains the necessary scripts for:
- extracting the reads mapping to mobile prophage regions (extractReads.sh, envs/*usedTools1*Env.yml)
- aligning the mobile prophage reads to their respective genomes (alignToOriginalGenome.sh, envs/*usedTools2*Env.yml)
- aligning the mobile prophage reads to all UZL genomes (Snakefile, config.yml, envs/*usedTools2*Env.yml)
- generating coverage plots with Samtools (singleUseCommands_SamtoolsCoverage.md, envs/samtoolsV1_11.yml)

*usedTools1* : bedtools, bwa, samtools

*usedTools2* : bwa, samtoolsV1_11

