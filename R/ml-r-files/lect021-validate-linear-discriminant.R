
######################################
### validating the linear discriminant
######################################

### we will use the validation set approach
### to compute the test set prediction accuracy

### create the training set and the test set

### generate a vector of random indices

n <- sample(45211, 22605)  

bank_train <- bank[n,]   # training set

bank_test<- bank[-n,]     # test set

### fit the model on the training set

fit <- lda(deposit~age+balance+duration, data = bank_train)

### make the predictions on the test set

pred_test <- predict(fit, newdata = bank_test)

class <- pred_test$class

head(class)

correct <- mean(bank_test$deposit == class)

correct

#################################

