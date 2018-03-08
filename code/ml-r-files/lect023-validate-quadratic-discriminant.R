
##########################################
### validating the quadratic discriminant
##########################################

### we will use the validation set approach
### to compute the test set prediction accuracy

### create the training set and the test set

### generate a vector of random indices

n <- sample(45211, 22610)

bank_train <- bank[n,]

bank_test<- bank[-n,]

### fit the model on the training set

fit <- qda(deposit~age+balance+duration, data = bank_train)

### compute the prediction accuracy on the test set

pred_test <- predict(fit, newdata = bank_test)

class <- pred_test$class

correct <- mean(bank_test$deposit == class)

correct

############################################

