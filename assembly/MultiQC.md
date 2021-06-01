# Command for MultiQC aggregation of quality control files


Used for both short read QC and assembly QC.

Information regarding the version and dependencies of the tool can be found in the environment file (envs/multiqcEnv.yml)

```
multiqc -d {foldersToSearch}
```
foldersToSearch = directories containing QC files from Kraken and FastQC (short reads) or Kraken and QUAST (assemblies).

