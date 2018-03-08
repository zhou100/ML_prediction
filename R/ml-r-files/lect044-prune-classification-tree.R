
############################
### pruning a classification tree
############################


phone <- read.csv("phone.csv")

View(phone)

### we'll prune the classification tree we previously built,
### using the cost complexity method

### compute the prediction accuracy in the test set
### for the initial tree

pred <- predict(fit, phone_test, type = "class")

mean(pred == phone_test$churn)

### print the cp table

printcp(fit)

### we will prune the tree with the prune() function

### extract the cp corresponding to the
### lower cross-validation error

ocp <- fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"]

ocp

prfit <- prune(fit, ocp)

rpart.plot(prfit)

### compute the prediction accuracy in the test set
### for the pruned tree

prpred <- predict(prfit, phone_test, type = "class")

mean(prpred == phone_test$churn)

### choose a greater cp calue to simplify the tree
### (by sacrificing prediction accuracy)

prfit2 <- prune(fit, 0.035)

rpart.plot(prfit2)

pred2 <- predict(prfit2, phone_test, type = "class")

mean(pred2 == phone_test$churn)
