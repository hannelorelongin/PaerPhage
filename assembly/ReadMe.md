# Assembly

This folder contains the necessary scripts for:
- going from raw reads to genome assemblies + associated QCs (Snakefile, config.yml, envs/*usedTools*Env.yml)
- aggregating the QC reports (singleUseCommands_MultiQC.md, envs/multiqcEnv.yml)
- statistical analysis of assemblies (statsAssemblies.R)

*usedTools* : bandage, fastqc, flye, kraken, krona, nanofilt, nanoplot, quast, seqkit, spades, trimm, unicycler
