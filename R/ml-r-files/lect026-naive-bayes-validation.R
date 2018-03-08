
##########################
## naive bayes model validation
##########################

bm <- read.csv("bankmarketing.csv")

View(bm)

### create the training set and the test set

i <- sample(45211, 22605)

bm_train <- bm[i,]

bm_test <- bm[-i,]

### build the prediction model on the training set

bayes <- naiveBayes(deposit ~ age + marital + education, data = bm_train)

### compute the prediction accuracy on the test set

pred <- predict(bayes, bm_test)

mean(pred == bm_test$deposit)

