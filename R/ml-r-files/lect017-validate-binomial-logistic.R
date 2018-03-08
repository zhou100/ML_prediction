
###################
### validating the logistic regression model
###################

### we will use the validation test approach
### in order to compute the prediction accuracy for the test set

### create the training and the test sets

### we extract at random about half of the cases in the bank data frame
### these will be the indices of the training set

n <- sample(45211, 22610)

bank_train <- bank[n,]

bank_test <- bank[-n,]

### fit the model on the training set

fit_train <- glm(deposit~age+marital+default+balance+housing+loan+duration, data=bank_train, family=binomial())

### compute the prediction accuracy on the TEST set

### estimate the probabilities of creating a deposit

pred.probs <- predict.glm(fit_train, newdata = bank_test, type = "response")

head(pred.probs)

### predict the customer behavior (in the TEST set)
### "no" (will not create a deposit) if the probability is lower than 0.50
### "yes" (will create a deposit) otherwise

pred <- ifelse(pred.probs<0.5,"no","yes")

head(pred)

### build the classification table

table(bank_test$deposit, pred)

### compute the prediction accuracy

accuracy <- mean(pred == bank_test$deposit)

accuracy

### build the ROC curve for the TEST set

require(ROCR)

pr <- prediction(pred.probs, bank_test$deposit)

perf <- performance(pr, measure = "tpr", x.measure = "fpr")

plot(perf)

auc <- performance(pr, measure = "auc")

auc


####################################


