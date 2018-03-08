
####################
## k nearest neighbor
## getting the optimal k
####################

### we use the tune.knn function in the e1071 package

### this function performs a 10-fold cross-validation

require(e1071)

t_knn <- tune.knn(phone2_train[,-4], factor(phone2_train[,4]), k = 1:100)

t_knn

plot(t_knn)

### run the knn algorithm with the optimal k

pred <- knn(train = phone2_train[,-4], test = phone2_test[,-4], cl = churn, k = 32)

### get the prediction accuracy

mean(pred == phone2_test$churn)

