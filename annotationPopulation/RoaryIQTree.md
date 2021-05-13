# Single use commans to generate the phylogenetic tree 


Relies on succesful annotation of all genomes as executed with the Snakefile.

Information regarding the version and dependencies of the two tools can be found in their environment files (*tool*.yml)


## Step 1: Roary - create core genome alignment

```
roary -e --mafft -v -p {threads} {locationGFF}
```
locationGFF = location of genome annotations in GFF format, when executed as in Snakefile this equals *prokka/allGFF/\*.gff*

## Step 2: IQTree - create tree

```
iqtree -s {input} -B 1000 -T AUTO -ntmax {threads} -v
```
input = core genome alignment produced with Roary
