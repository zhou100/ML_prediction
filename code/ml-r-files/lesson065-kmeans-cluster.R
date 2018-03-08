
######################
### k-means cluster analysis
######################

wines <- read.csv("winequality.csv")

View(wines)

### we will cluster the wines by their characteristics


####### data preparation

### remove the missing values

wines <- na.omit(wines)

### create a matrix with all the clustering variables

wines2 <- cbind(wines$fixed.acidity, wines$volatile.acidity, wines$citric.acid, 
                wines$residual.sugar, wines$chlorides, wines$free.sulfur.dioxide, 
                wines$total.sulfur.dioxide, wines$density, wines$pH, wines$sulphates,
                wines$alcohol)

### standardize the clustering variables (recommended)

wines2 <- scale(wines2)

### name the columns

colnames(wines2) <- c("fixed.acidity", "volatile.acidity", "citric.acid", 
                      "residual.sugar", "chlorides", "free.sulfur.dioxide", 
                      "total.sulfur.dioxide", "density", "pH", "sulphates",
                      "alcohol")

View(wines2)

wines2 <- as.data.frame(wines2)

### run the k-means algorithm, with three clusters

model <- kmeans(wines2, 3)

### get information about cluster membership

### clustering vector

member3 <- model$cluster

### add the clustering variable to the data frame wines2

wines2 <- cbind(wines2, member3)

View(wines2)


########## compute some summary statistics for the three clusters

require(dplyr)

summ <- wines2 %>% group_by(member3) %>% 
  summarize_each(funs(mean), fixed.acidity, volatile.acidity, citric.acid, residual.sugar,
                 chlorides, free.sulfur.dioxide, total.sulfur.dioxide, density, pH,
                 sulphates, alcohol)

View(summ)

