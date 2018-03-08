
#####################
## naive bayes estimation
## using the e1071 package
######################

bm <- read.csv("bankmarketing.csv")

View(bm)

### we want to predict whether a customer will open a deposit
### knowing their age, marital status and education level

require(e1071)

### create the naive bayes model

bayes <- naiveBayes(deposit ~ age + marital + education, data = bm)

bayes

### get the predicted values

pred <- predict(bayes, bm)

head(pred)

tail(pred)

### compute the prediction accuracy

table(bm$deposit, pred)

mean(pred == bm$deposit)

### how to use the model to predict the behavior for new observations

### simulate new data (60 new customers)

newcust <- data.frame(age=21:80, 
                      marital=rep(c("single", "married", "divorced"), 60),
                      education=rep(c("primary", "tertiary", "secondary"), each = 60))

View(newcust)

pred2 <- predict(bayes, newcust)

pred2

newcust2 <- cbind(newcust, prediction = pred2)

View(newcust2)

