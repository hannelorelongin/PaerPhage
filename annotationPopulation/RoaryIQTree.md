# Single use commans to generate the phylogenetic tree when Prokka annotation has succeeded

Information regarding the version and dependencies of the two tools can be found in their environment files (*tool*.yml)

## Step 1: Roary - create core genome alignment

```
roary -e --mafft -v -p {threads} prokka/allGFF/*.gff
```
## Step 2: IQTree - create tree

```
iqtree -s {input} -B 1000 -T AUTO -ntmax 15 -v
```
input = core genome alignment produced with Roary
