##Statistical comparison of different assemblers 

##clearing the environment, reading in the data
rm(list=ls())
data=read.table("contLengthN50.txt", header=TRUE)

##checking normality
shapiro.test(data$contigs) ##significantly different from normal distribution
shapiro.test(data$length) ##significantly different from normal distribution
shapiro.test(data$N50) ##significantly different from normal distribution

##testing effect assembler
kruskal.test(contigs ~ assembler, data = data) ##significant
kruskal.test(length ~ assembler, data = data) ##not significant
kruskal.test(N50 ~ assembler, data = data) ##significant

##find significant pairs
pairwise.wilcox.test(data$contigs, data$assembler, p.adjust.method = "holm") ##all significant except flye - unicycler
pairwise.wilcox.test(data$N50, data$assembler, p.adjust.method = "holm") ##all significant except flye - unicycler

##plotting
library(ggplot2)
library(ggpubr)
library(scales)

my_comparisons = list(c("flye", "spades"), c("flye", "unicycler"), c("spades", "unicycler"))
 
plotContigs = ggplot(data, aes(x=assembler, y=contigs, fill=assembler)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(shape=16, position=position_jitter(0.2)) + 
  labs(y="number of contigs") + stat_compare_means(comparisons = my_comparisons) +
  scale_y_continuous(labels = scientific)
plotLength = ggplot(data[data$length < 7306678,], aes(x=assembler, y=length, fill=assembler)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(shape=16, position=position_jitter(0.2)) + 
  labs(y="Genome size") + stat_compare_means(label.x.npc = "center") 
plotN50 = ggplot(data, aes(x=assembler, y=N50, fill=assembler)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(shape=16, position=position_jitter(0.2)) + 
  stat_compare_means(comparisons = my_comparisons) +
  scale_y_continuous(labels = scientific)
plotContigs
plotLength 
plotN50 
