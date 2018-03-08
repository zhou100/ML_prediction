
###################
# validating the ridge regression model
##################


### create the model variables again

x <- model.matrix(burglPerPop~., crim2)[,-1]

y <- crim2$burglPerPop

### next we split the sample in a training set and a test set
### so we are able to compute the TEST mean squared error

### the test set will be half of the number of cases

### we generate 1106 random numbers in the 1-2212 range
### these random numbers will be the indices of the TRAINING set

n <- sample(2212, 1106)

### now we fit the model on the training set 
### performing a k-fold cross-validation with 10 folds
### in order to get the lambda of the best model (optimum lambda)

### to do that we use the cv.glmnet() function in the glmnet package

require(glmnet)

### fit the model

cv.fit <- cv.glmnet(x[n,], y[n], alpha = 0, nfolds = 10)

### we do not have to set lambda in the cv.glmnet() function

### the program identifies the lambdas that result in the 
### smallest cross-validation error

### get the lambda for the best model

optlambda <- cv.fit$lambda.min

optlambda

### now we predict the y values for the test set
### using the optimum lambda
### and compute the mean squared error

pred <- predict(cv.fit, s=optlambda, newx = x[-n,])

head(pred)

mse_test <- mean((pred - y[-n])^2)

mse_test


################################

