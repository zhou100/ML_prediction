
##############################################
### validating the lasso logistic regression
##############################################

### create the matrices of the variables

x <- model.matrix(deposit~age+marital+default+balance+housing+loan+duration, bank)[,-1]

y <- bank$deposit


### we will use the cv.glmnet() function from the glmnet package

### we are going ot create a training set and a test set
### and run the model on the training set, with cross-validation
### to determine the optimal lambda

### create the sample of indices for the TRAINING set

n <- sample(45211, 22605)

head(n)

### create the test set

bank_test <- bank[-n,]

### fit the regression on the TRAINING set

cv.fit <- cv.glmnet(x[n,], y[n], alpha = 1, nfolds = 10, family = "binomial")

### get the lambda for the lowest cross-validation error

optlambda <- cv.fit$lambda.min

optlambda

### predict the probability to make a deposit for the TEST set

pred.probs <- predict(cv.fit, s=optlambda, newx = x[-n,], type = "response")

head(pred.probs)

### predict the customer behavior on the test set
### "no" (will not create a deposit) if the probability is lower than 0.50
### "yes" (will create a deposit) otherwise

estclass <- ifelse(pred.probs<0.5, "no", "yes")

head(estclass)

### compute the prediction accuracy

acc <- mean(estclass == bank_test$deposit)

acc

### find out the coefficients for the best model

### create the vector of lambdas and fit the lasso model again

w <- seq(10, -3, length=100)

lvalues <- 10 ^ w

fit <- glmnet(x, y, alpha = 1, lambda = lvalues, family = "binomial")


### print the coefficients of the best model

predict(fit, s = optlambda, type = "coefficients")

##################

### could a more parcimonious model perform (almost) as well as the optimal model?

fit$lambda[88]

### compute the prediction accuracy for this value of lambda,
### because our model only has two significant predictors:
### housing and duration

pred_probs2 <- predict(fit, s = 0.03764936, type = "response", newx = x[-n,])

estclass2 <- ifelse(pred_probs2<0.5, "no", "yes")

acc <- mean(estclass2 == bank_test$deposit)

acc

###############################

