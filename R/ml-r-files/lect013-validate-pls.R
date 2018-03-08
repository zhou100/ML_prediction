
################################
# validating the pls regression
################################



### create the training set and the test set

### extract 1106 random numbers in the 1-2212 range

n <- sample(2212, 1106)

crim2_train <- crim2[n,]

crim2_test <- crim2[-n,]

### fit the pls model with 8 components on the training set

fit <- plsr(burglPerPop~., data = crim2_train, scale = TRUE, ncomp = 8)

### compute the mse on the test set

pred <- predict(fit, crim2_test, ncomp = 8)

head(pred)

mse <- mean((pred - crim2_test$burglPerPop)^2)

mse

######################################


