
##########################
## naive bayes estimation
## using the naivebayes package
##########################

bm <- read.csv("bankmarketing.csv")

View(bm)

### we want to predict whether a customer will open a deposit
### knowing their age, marital status and education level

require(naivebayes)

### create the training set and the test set

i <- sample(45211, 22605)

bm_train <- bm[i,]

bm_test <- bm[-i,]

### create the naive bayes classification model in the training set

bayes2 <- naive_bayes(deposit ~ age + marital + education, data = bm_train)

### print the whole output

bayes2

### print the tables only

bayes2$tables

### compute the prediction accuracy in the test set

pred <- predict(bayes2, bm_test)

mean(pred == bm_test$deposit)

### plot the distributions of the predictors

plot(bayes2)
