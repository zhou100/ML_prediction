
#########################
# best subset validation
#########################



### the validation process for the subset regression is pretty complicated
### because there is no predict method for the regsubsets function
### so we cannot automaticaly extract the predicted values of the response variable
### or the coefficients for the best model

### therefore we have to compute the test set adjusted R squared using a double loop

### this double loop will do the following:

# 1. find the best model for each set of variables, using a k-fold cross-validation
# 2. capture the coefficients of this best model
# 3. compute the adjusted R squared on the TEST set, using these coefficients
# 4. find the number of variables that ensures the highest R squared on the TEST set

### create the ten folds for the k-fold cross-validation

k <- 10

i <- 1:k

fold <- sample(i, nrow(crim2), replace = TRUE)

length(fold)

fold[1:100]

### initialize the vector that will contain the number of predictors
### of the best model for EACH fold

vect_optnpred <- c()

### initialize the vector that will contain the TEST set adjusted R squared
### of the best model for EACH fold

vect_adjr2 <- c()

############ THE LOOP STARTS HERE

### the j index represents the TEST set

for (j in i)  {
  
  # fit the model on the TRAINING set

fit_train <- regsubsets(burglPerPop~., crim2[fold != j,], nvmax=16)

  # get the model summary

summ_train <- summary(fit_train)

  # find the number of predictors for the best model (highest R squared)

optnpred <- which.max(summ_train$adjr2)

  # add this number to the vect_optnpred vector

vect_optnpred <- c(vect_optnpred, optnpred)

  # extract the coefficients of the best model

coef <- coef(fit_train, optnpred)

  # get the predictor names corresponding to these coefficients
  # (less the intercept)

preds <- names(coef[-1])

  # initialize the matrix of the predictors (to be used in the regression model later)

xmat <- c()

  #### here starts the second loop

for (w in 1:optnpred)  {
  
  # for each predictor we extract those values in the data frame
  # that correspond to the TEST set
  # and put them in the xmat matrix
  
  xmat <- cbind(xmat, crim2[fold == j, preds[w]])
  
}

  # convert xmat into a data frame

xmat <- data.frame(xmat)

  # add column names to xmat (the predictors names)

colnames(xmat) <- preds

  # extract the values of the dependent variable
  # that correspond to the TEST set

burglPerPop <- crim2[fold == j,]$burglPerPop

   # add the dependent variable to xmat and create the matrix
   # of the model variables, varsmat

varsmat <- cbind(xmat, burglPerPop)

   # now we can fit the regression model for the optimum number of predictors
   # on the TEST set, to find out the adjusted R squared on this set

fit_test <- lm(burglPerPop~., data = varsmat)

    # get the model summary

summ_test <- summary(fit_test)

    # extract the adjusted R squared

adjr2 <- summ_test$adj.r.squared

    # add the adjusted R squared to the vect_adjr2 vector

vect_adjr2 <- c(vect_adjr2, adjr2)

}

################## LOOP ENDS HERE

### print the two resulted vectors

vect_optnpred

vect_adjr2

### get the index of the maximum adjusted R squared

which.max(vect_adjr2)

### to find out the regression coefficients for the best model
### (and the predictors to be included in this model)
### run the regsubsets function again, on the last fold
 

fit10 <- regsubsets(burglPerPop~., crim2[fold == 10,], nvmax = 16)

coef(fit10, 11)

###################################

