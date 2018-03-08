
########################
### hierarchical cluster analysis
########################

crime <- read.csv("crimes.csv")

View(crime)

### we will cluster the communities by the following variables:
### murders, rapes,	robberies, assaults,	burglaries,	larcenies,
### auto thefts, arsons,	non violent crimes
### (all of them per 100,000 population)

### create a new data set with the clustering variables

crime_work <- crime[,-1]

View(crime_work)

### add row names

rownames(crime_work) <- crime$communityname

### compute the distance matrix

dm <- dist(crime_work, method = "euclidean")

### create the clustering model
### using the hclust function

model <- hclust(dm, method = "ward.D")

### plot the model (as a dendrogram)

plot(model, labels=rownames(crime_work))

### get cluster membership for each case (community)
### in the case of 3 clusters

member <- cutree(model, k=3)

member

### visualize clusters on the dendrogram

rect.hclust(model, k=2, border="red")

############# compute some summary data for each cluster

### add a cluster membership variable to the data frame

crime2 <- cbind(crime, cluster3 = member)

View(crime2)

### compute the mean of each clustering variable in each cluster

require(dplyr)

crimesumm <- crime2 %>% group_by(cluster3) %>%
  summarize_each(funs(mean), murdPerPop, rapesPerPop, robbbPerPop, assaultPerPop, burglPerPop,
                 larcPerPop, autoTheftPerPop, arsonsPerPop, nonViolPerPop)

View(crimesumm)

### get the list of communities in each cluster

split(crime2$communityname, factor(crime2$cluster3))


