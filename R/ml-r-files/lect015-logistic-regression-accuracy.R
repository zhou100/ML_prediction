
###########################
### binomial logistic regression
### compute the prediction accuracy
###########################

### the prediction accuracy is given by the percentage of correctly classified cases

### predict the probability to create a deposit for each case

pred.probs <- predict(fit, type = "response")

head(pred.probs)

### predict the customer behavior
### "no" (will not create a deposit) if the probability is lower than 0.50
### "yes" (will create a deposit) otherwise

pred <- ifelse(pred.probs<0.5,"no","yes")

head(pred)

tail(pred)

### create the classification table

table(bank$deposit, pred)

### the number of correctly classified cases can be found in the main diagonal

### compute the prediction accuracy

accuracy <- mean(pred == bank$deposit)   # the percentage of correctly classified cases

accuracy

### we can also directly compute the percentage of misclassified cases

miscl <- mean(pred != bank$deposit)

miscl

#####################################3

