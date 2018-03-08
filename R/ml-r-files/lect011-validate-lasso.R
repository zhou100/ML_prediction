
#######################
# validating the lasso regression
######################


### we create the matrices

x <- model.matrix(burglPerPop~., crim2)[,-1]

y <- crim2$burglPerPop

### first we split the sample in a training set and a test set
### so we are able to compute the test mean squared error

### the test set wil contain half of the number of cases

### we generate 1106 random numbers in the 1-2212 range
### these will be the indices of the training set

n <- sample(2212, 1106)

### now we fit the model on the training set 
### performing a k-fold cross-validation with 10 folds
### in order to get the lambda of the best model (optimum lambda)

### to do that we use the cv.glmnet() function in the glmnet package

require(glmnet)

### perform the cross-validation (alpha is set to 1)

cv.fit <- cv.glmnet(x[n,], y[n], alpha = 1, nfolds = 10)

### get the lambda for the lowest cross-validation error

optlambda <- cv.fit$lambda.min

optlambda

### now we predict the y values for the test set
### using the optimum lambda
### and compute the mse

pred <- predict(cv.fit, s=optlambda, newx = x[-n,])

head(pred)

mse_test <- mean((pred - y[-n])^2)

mse_test



### find out the coefficients for the best model

### create the vector of lambdas and fit the lasso model again

w <- seq(10, -3, length=100)

lvalues <- 10 ^ w

fit <- glmnet(x, y, alpha = 1, lambda = lvalues)


### print the coefficients of the best model

predict(fit, s = optlambda, type = "coefficients")

###############################

