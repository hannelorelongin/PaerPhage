##R code to extract information from the regions - Tariq dataset

#########################
#  PREPARING THE DATA   #
#########################

##Clearing the environment
rm(list=ls())

##Read all input files
  ##Region based
filelistReg = list.files(pattern="*.region")
for (i in 1:length(filelistReg)) assign(filelistReg[i], read.csv(filelistReg[i],sep="\t",header = FALSE, col.names = c("CONTIG","START","STOP")))
  ##Position based
filelistPos = list.files(pattern="*.pos")
for (i in 1:length(filelistPos)) assign(filelistPos[i], read.csv(filelistPos[i],sep="\t", dec = ",",header = FALSE, col.names = c("CONTIG","START","READS","DEPTH")))
  ##Complete depth files
filelistCov = list.files(pattern="*.depth")
for (i in 1:length(filelistCov)) assign(filelistCov[i], read.csv(filelistCov[i],sep="\t",header = FALSE, col.names = c("CONTIG","START","DEPTH")))

##List all dataframes for further manipulation
e = .GlobalEnv
dflistReg = ls(pattern = ".region", envir = e)
dflistCov = ls(pattern = ".depth", envir = e)

#########################
# MANIPULATING THE DATA #
#########################

##Additional parameters for the dataframe - pt1
  ##Extract length of region
addLength = function(df){
  df$LENGTH = 1+ df$STOP - df$START
  df$NUMGROUPS = nrow(df)
  df$LENGTH[is.na(df$STOP)] = 1
  return(df)
}
for(i in dflistReg) e[[i]] = addLength(e[[i]])

  ##add fold change in read depth
addFold = function(df){
  df$fold = df$DEPTH/mean(df$DEPTH)
  return(df)
}
for(i in dflistCov) e[[i]] = addFold(e[[i]])

  ##add phages found in PHASTER with their status to the correct positions
   ##helper function: add binary variable at correct positions
addPhageCol = function(df,colName,contig,start,stop,status){
  colName = ifelse(df$CONTIG == contig & df$START >= start & df$START <= stop,as.character(status),0)
  return(colName)
}
    ##actual function
addPhagePHASTER = function(inputPHASTER,inputPaLo){
  phage = read.csv(inputPHASTER,sep="\t",header=F,col.names=c("CONTIG","START","STOP","STATUS"))
  testDf = data.frame(matrix(ncol=0,nrow=nrow(inputPaLo)))
  for (row in 1:nrow(phage)) {
    testDf[,paste("phage",row,sep="")] = addPhageCol(inputPaLo,paste("phage",row,sep=""),phage[row,"CONTIG"],phage[row,"START"],phage[row,"STOP"],phage[row,"STATUS"])
  }
  return(cbind(inputPaLo,testDf))
}
  ##apply function (not automated as each file required different input file containing phages)
all2PaLo3.depth = addPhagePHASTER("phagesPaLo3.txt", all2PaLo3.depth)
all2PaLo4.depth = addPhagePHASTER("phagesPaLo4.txt", all2PaLo4.depth)
all2PaLo8.depth = addPhagePHASTER("phagesPaLo8.txt", all2PaLo8.depth)
all2PaLo9.depth = addPhagePHASTER("phagesPaLo9.txt", all2PaLo9.depth)
all2PaLo11.depth = addPhagePHASTER("phagesPaLo11.txt", all2PaLo11.depth)
all2PaLo12.depth = addPhagePHASTER("phagesPaLo12.txt", all2PaLo12.depth)
all2PaLo30.depth = addPhagePHASTER("phagesPaLo30.txt", all2PaLo30.depth)
all2PaLo32.depth = addPhagePHASTER("phagesPaLo32.txt", all2PaLo32.depth)
all2PaLo33.depth = addPhagePHASTER("phagesPaLo33.txt", all2PaLo33.depth)
all2PaLo34.depth = addPhagePHASTER("phagesPaLo34.txt", all2PaLo34.depth)
all2PaLo38.depth = addPhagePHASTER("phagesPaLo38.txt", all2PaLo38.depth)
all2PaLo39.depth = addPhagePHASTER("phagesPaLo39.txt", all2PaLo39.depth)
all2PaLo40.depth = addPhagePHASTER("phagesPaLo40.txt", all2PaLo40.depth)
all2PaLo41.depth = addPhagePHASTER("phagesPaLo41.txt", all2PaLo41.depth)
all2PaLo42.depth = addPhagePHASTER("phagesPaLo42.txt", all2PaLo42.depth)
all2PaLo43.depth = addPhagePHASTER("phagesPaLo43.txt", all2PaLo43.depth)
all2PaLo44.depth = addPhagePHASTER("phagesPaLo44.txt", all2PaLo44.depth)
all2PaLo45.depth = addPhagePHASTER("phagesPaLo45.txt", all2PaLo45.depth)
all2PaLo46.depth = addPhagePHASTER("phagesPaLo46.txt", all2PaLo46.depth)
all2PaLo47.depth = addPhagePHASTER("phagesPaLo47.txt", all2PaLo47.depth)

  ##Add 1 column containing info on phage found (instead of seperate column per phage)
    ##helper function
findStringRow = function(string,df){
  apply(df, 1, function(r) any(r %in% string))
}
    ##actual function
add1Phage = function(df){
  subsetPhage = df[grepl("phage",colnames(df))]
  phage = ifelse(findStringRow("intact",df),"intact",ifelse(findStringRow("incomplete",df),"incomplete",ifelse(findStringRow("questionable",df),"questionable","none")))
  phage = as.factor(phage)
  df2 = cbind(df,phage)
  return(df2)
}
for(i in dflistCov) e[[i]] = add1Phage(e[[i]])

  ##Combine all dfs to one large per type of df (not possible for large depth files)
library(data.table)
mergedReg = rbindlist(mget(ls(pattern = ".region")), idcol = TRUE)
mergedPos = rbindlist(mget(ls(pattern = ".pos")), idcol = TRUE)

  ##function to assign correct pt to PaLo
addSamplePair = function(df,ftype){
  df$sample[df$.id == paste("all2PaLo3.highDepth.",ftype,sep="")] = "pt01_PaLo3"
  df$sample[df$.id == paste("all2PaLo4.highDepth.",ftype,sep="")] = "pt01_PaLo4"
  df$sample[df$.id == paste("all2PaLo8.highDepth.",ftype,sep="")] = "pt02_PaLo8"
  df$sample[df$.id == paste("all2PaLo9.highDepth.",ftype,sep="")] = "pt02_PaLo9"
  df$sample[df$.id == paste("all2PaLo11.highDepth.",ftype,sep="")] = "pt03_PaLo11"
  df$sample[df$.id == paste("all2PaLo12.highDepth.",ftype,sep="")] = "pt03_PaLo12"
  df$sample[df$.id == paste("all2PaLo30.highDepth.",ftype,sep="")] = "pt04_PaLo30"
  df$sample[df$.id == paste("all2PaLo34.highDepth.",ftype,sep="")] = "pt04_PaLo34"
  df$sample[df$.id == paste("all2PaLo32.highDepth.",ftype,sep="")] = "pt05_PaLo32"
  df$sample[df$.id == paste("all2PaLo33.highDepth.",ftype,sep="")] = "pt05_PaLo33"
  df$sample[df$.id == paste("all2PaLo38.highDepth.",ftype,sep="")] = "pt06_PaLo38"
  df$sample[df$.id == paste("all2PaLo45.highDepth.",ftype,sep="")] = "pt06_PaLo45"
  df$sample[df$.id == paste("all2PaLo39.highDepth.",ftype,sep="")] = "pt07_PaLo39"
  df$sample[df$.id == paste("all2PaLo44.highDepth.",ftype,sep="")] = "pt07_PaLo44"
  df$sample[df$.id == paste("all2PaLo40.highDepth.",ftype,sep="")] = "pt08_PaLo40"
  df$sample[df$.id == paste("all2PaLo47.highDepth.",ftype,sep="")] = "pt08_PaLo47"
  df$sample[df$.id == paste("all2PaLo41.highDepth.",ftype,sep="")] = "pt09_PaLo41"
  df$sample[df$.id == paste("all2PaLo46.highDepth.",ftype,sep="")] = "pt09_PaLo46"
  df$sample[df$.id == paste("all2PaLo42.highDepth.",ftype,sep="")] = "pt10_PaLo42"
  df$sample[df$.id == paste("all2PaLo43.highDepth.",ftype,sep="")] = "pt10_PaLo43"
  df$pt[df$.id == paste("all2PaLo3.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo4.highDepth.",ftype,sep="")] = "pt01"
  df$pt[df$.id == paste("all2PaLo8.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo9.highDepth.",ftype,sep="")] = "pt02"
  df$pt[df$.id == paste("all2PaLo11.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo12.highDepth.",ftype,sep="")] = "pt03"
  df$pt[df$.id == paste("all2PaLo30.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo34.highDepth.",ftype,sep="")] = "pt04"
  df$pt[df$.id == paste("all2PaLo32.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo33.highDepth.",ftype,sep="")] = "pt05"
  df$pt[df$.id == paste("all2PaLo38.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo45.highDepth.",ftype,sep="")] = "pt06"
  df$pt[df$.id == paste("all2PaLo39.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo44.highDepth.",ftype,sep="")] = "pt07"
  df$pt[df$.id == paste("all2PaLo40.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo47.highDepth.",ftype,sep="")] = "pt08"
  df$pt[df$.id == paste("all2PaLo41.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo46.highDepth.",ftype,sep="")] = "pt09"
  df$pt[df$.id == paste("all2PaLo42.highDepth.",ftype,sep="") | df$.id == paste("all2PaLo43.highDepth.",ftype,sep="")] = "pt10"
  return(df)
}
mergedReg = addSamplePair(mergedReg,"region")
mergedPos = addSamplePair(mergedPos,"pos")

#########################
#      STATISTICS       #
#########################

##Statistics
  ##Q1: is region size dependent on sample?
    ##test normality - no Shapiro test since too large sample
library(nortest)
ad.test(mergedReg$LENGTH) ##very significant p-value: non normally distributed
    ##test role of sample
kruskal.test(LENGTH ~ sample, data = mergedReg) ##very significant (Tariq) - non significant (Coffey)
    ##pairwise comparisons
pairwise.wilcox.test(mergedReg$LENGTH, mergedReg$sample, p.adjust.method = "holm")
  ##Q2: is depth dependent on sample
    ##test normality - no Shapiro test since too large sample
ad.test(mergedPos$DEPTH) ##very significant p-value: non normally distributed
    ##test role of sample
kruskal.test(DEPTH ~ sample, data = mergedPos) ##very significant
    ##pairwise comparisons
pairwise.wilcox.test(mergedPos$DEPTH, mergedPos$sample, p.adjust.method = "holm")

#########################
#       PLOTTING        #
#########################

##Plotting 
  ##libraries
library(ggplot2)
library(ggpubr)
library(hexbin)
library(ggrastr)
  ##Plot1: number of groups vs size of group
plotLenGroup  = ggplot(mergedReg, mapping = aes(x = LENGTH, y = NUMGROUPS))
plotLenGroup + 
  geom_bin2d() + 
  scale_fill_continuous(low="red", high="blue")  + 
  labs(title="Size versus number of regions", 
       subtitle = "for continuous regions with increased average in 20 paired samples") +
  xlab("size (nt)") +
  ylab("number of regions")
  ##Plot2: histogram of length: most clusters are tiny
qplot(x = mergedReg$LENGTH, geom="histogram",log = "x",main="Histogram of size of continuous regions",xlab="size (nt) - log transformed") 
qplot(x = mergedReg$LENGTH, geom="histogram", main="Histogram of size of continuous regions",xlab="size (nt)") ##non log to show why we need log
  ##Plot3: boxplot of size of regions with increased depth per sample
plotLENGTH = ggplot(mergedReg, aes(x=sample, y=LENGTH, col=factor(pt))) +
  geom_boxplot(outlier.color = NULL) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), legend.position = "none")  + 
  labs(title="Size of continuous regions with increased read depth", 
       subtitle = "boxplot per sample") +
  xlab("sample (format ptX_PaLoY)") +
  ylab("size") 
plotLENGTH
  ##Plot4: histogram of read depth for regions of increase
qplot(x = mergedPos$DEPTH, geom="histogram",main="Histogram of fold change in read depth (increase only)",xlab="fold change")
  ##Plot5: boxplot of read depth per sample, with outliers
plotCOV = ggplot(mergedPos, aes(x=sample, y=DEPTH, fill=pt)) +
  geom_boxplot_jitter() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), legend.position = "none")  + 
  labs(title="Fold increase in read depth ", 
       subtitle = "boxplot per sample") +
  xlab("sample (format ptX_PaLoY)") +
  ylab("fold increase") 
plotCOV
  ##Plot6: boxplot of read depth for regions of increase per sample, w/o outliers
plotCOV2 = ggplot(mergedPos, aes(x=sample, y=DEPTH, fill = pt)) +
  geom_boxplot(outlier.shape = NA) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), legend.position = "none")  + 
  labs(title="Fold increase in read depth ", 
       subtitle = "boxplot per sample") +
  xlab("sample (format ptX_PaLoY)") +
  ylab("fold increase") + ylim(0,50) ##for Coffey: replace ylim(0,50) to ylim(0,7.5)
plotCOV2

#########################
#        STORAGE        #
#########################

  ##storing the annotated coverage files for future use
write.table(all2PaLo3.depth, file='all2PaLo3.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo4.depth, file='all2PaLo4.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo8.depth, file='all2PaLo8.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo9.depth, file='all2PaLo9.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo11.depth, file='all2PaLo11.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo12.depth, file='all2PaLo12.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo30.depth, file='all2PaLo30.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo32.depth, file='all2PaLo32.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo33.depth, file='all2PaLo33.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo34.depth, file='all2PaLo34.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo38.depth, file='all2PaLo38.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo39.depth, file='all2PaLo39.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo40.depth, file='all2PaLo40.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo41.depth, file='all2PaLo41.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo42.depth, file='all2PaLo42.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo43.depth, file='all2PaLo43.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo44.depth, file='all2PaLo44.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo45.depth, file='all2PaLo45.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo46.depth, file='all2PaLo46.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
write.table(all2PaLo47.depth, file='all2PaLo47.cov.tsv', quote=FALSE, sep='\t', col.names = NA)
