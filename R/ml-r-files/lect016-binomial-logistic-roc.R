
###########################
### binomial logistic regression
### drawing the ROC curve
###########################


### we will use the ROCR package

require(ROCR)

### fit the model and compute the estimated probabilities

fit <- glm(deposit~age+marital+default+balance+housing+loan+duration, data=bank, family=binomial())

pred.probs <- predict(fit, type = "response")

### create the prediction object

pr <- prediction(pred.probs, bank$deposit)

### create the performance object

perf <- performance(pr, x.measure = "fpr", measure = "tpr")

### tpr is the true positives ratio (sensitivity)

### fpr is the false positives ratio (1 - specificity)

### plot the performance object

plot(perf)

### compute the area under curve (auc)

auc <- performance(pr, measure = "auc")

auc


###############################################

