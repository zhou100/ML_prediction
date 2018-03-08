
###################
# partial least squares regression
##################


crim <- read.csv("commcrime.csv")

crim2 <- crim[complete.cases(crim),]

View(crim2)

### we will use the plsr function in the pls package

require(pls)

### in this lecture we'll perform a k-fold cross-validation
### to determine the optimal number of components

### in the next lecture we'll validate the model using the set validation approach
### to determine the test mean squared error

### fit the model with k-fold cross-validation

fit <- plsr(burglPerPop~., data = crim2, scale = TRUE, validation = "CV")

### the option scale is set to true because it is recommended that
### the variables are standardized before running a pls regression

### the validation parameter has the "CV" value, so we require a 
### k-fold cross-validation (the default number of folds is 10)

summary(fit)

### the plsr function computes the root mean squared error (rmse)
### so in order to get the mse for a model we have to square the rmse

### get the predictor coefficients for the model with 8 components

coef(fit, 8)

### the summary function also reports the percentage of variance explained
### this shows the amount of information in the predictors
### that is explained by the components


### we can fit the model with the optimal number of components

fit2 <- plsr(burglPerPop~., data = crim2, scale = TRUE, ncomp = 8)

summary(fit2)

coef(fit2)

####################################

