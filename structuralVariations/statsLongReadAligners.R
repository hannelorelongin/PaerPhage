##Comparison of different long read alignment tools

##clearing the environment, reading in the data
rm(list=ls())
data = read.table("mapAlignStats.txt", header=TRUE, colClasses = c("factor","factor", "numeric", "numeric", "numeric"), dec=".")
timing = read.table("mapTimeStats.txt", header=TRUE, dec=".")

##checking for assumption of normality
shapiro.test(data$mapq) ##significantly different from normal distribution
shapiro.test(data$peralign) ##significantly different from normal distribution
shapiro.test(data$error) ##significantly different from normal distribution
shapiro.test(timing$time_s) ##significantly different from normal distribution

##testing for difference in means of groups and role of alignment tool and assembly tool 
kruskal.test(mapq ~ aligner, data = data) ##significant
kruskal.test(mapq ~ assembly, data = data) ##not significant
kruskal.test(peralign ~ aligner, data = data) ##significant
kruskal.test(peralign ~ assembly, data = data) ##not significant
kruskal.test(error ~ aligner, data = data) ## significant
kruskal.test(error ~ assembly, data = data) ##not significant
kruskal.test(time_s ~ aligner, data = timing) ##significant
kruskal.test(time_s ~ assembly, data = timing) ##not significant
  ##only alignment tool seems to be needed to explain differences in mean

##pairwise testing for significant pairs
pairwise.wilcox.test(data$mapq, data$aligner, p.adjust.method = "holm") ##mapq: every pair is significant except graphC vs graphNC
pairwise.wilcox.test(data$peralign, data$aligner, p.adjust.method = "holm") ##ngmlr is significantly different from others
pairwise.wilcox.test(data$error, data$aligner, p.adjust.method = "holm") ##graph(C/NC) is significantly different from ngmlr and minimap
pairwise.wilcox.test(timing$time_s, timing$aligner, p.adjust.method = "holm") ##minimap significantly different from rest

##plotting
library(ggplot2)
library(ggpubr)
library(scales)

theme_update(text = element_text(size=15))

comMapQ = list(c("graphC", "mini"), c("graphC", "ngmlr"), c("graphNC","mini"), c("graphNC", "ngmlr"), c("mini", "ngmlr"))
plotMapQ = ggplot(data, aes(x=aligner, y=mapq, fill=aligner)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(shape=16, position=position_jitter(0.2)) + 
  stat_compare_means(comparisons = comMapQ, size=5) +
  scale_y_continuous(labels = scientific) + labs(y="mapping quality")
comError = list(c("graphC", "mini"), c("graphC", "ngmlr"), c("graphNC","mini"), c("graphNC", "ngmlr"))
plotError = ggplot(data, aes(x=aligner, y=error, fill=aligner)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(shape=16, position=position_jitter(0.2)) + 
  stat_compare_means(comparisons = comError, size=5, label.y = c(0.098,0.101,0.104,0.107,0.110,0.113)) +
  scale_y_continuous(labels = percent) + labs(y="error rate")
comPerAlign = list(c("graphC", "ngmlr"), c("graphNC", "ngmlr"), c("mini", "ngmlr"))
plotPeralign = ggplot(data, aes(x=aligner, y=peralign, fill=aligner)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(shape=16, position=position_jitter(0.2)) + 
  stat_compare_means(comparisons = comPerAlign, size=5, label.y = c(1.003,1.006,1.009)) +
  scale_y_continuous(labels = percent) + labs(y="percentage aligned reads")
comTime = list(c("graphC", "mini"),c("graphNC","mini"), c("mini", "ngmlr"))
plotTime = ggplot(timing, aes(x=aligner, y=time_s, fill=aligner)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(shape=16, position=position_jitter(0.2)) + 
  stat_compare_means(comparisons = comTime, size=5, label.y = c(880,1000,1120)) +
  scale_y_continuous(labels = scientific) + labs(y="run time (seconds)")
plotMapQ ##want this to be high - minimap is significantly best
plotPeralign ##want this to be high - ngmlr is significantly the worst
plotError ##want this to be low - ngmlr and mini best
plotTime ##want this to be low - minimap is best and significantly different from others
