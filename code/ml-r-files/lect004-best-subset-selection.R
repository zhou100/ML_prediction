
#################
# best subset selection
#################

crim <- read.csv("commcrime.csv")

crim2 <- crim[complete.cases(crim),]

View(crim2)

### to run the regression with the best subset selection
### we will use the regsubsets function from the package leaps

require(leaps)

fit <- regsubsets(burglPerPop~., crim2, nvmax = 16)

### nvmax is the maximum number of predictors to be included in the model
### by default it is set to 8

summ <- summary(fit)

summ

### to assess the goodness-of-fit we will use the adjusted R square
### because it is automatically computed for each model

summ$adjr2

### find the model with maximum adjusted R squared

which.max(summ$adjr2)

### print the coefficients of this model

coef(fit, 12)

### we can pick a model with even less variables
### which is more easy to intepret

### for example, the model with 8 variables

coef(fit, 8)

### the regsubset() function does not provide more info about the models
### for example, the p-values for the coefficients or the F-statistic

### if we want this info, we have to run the model with the retained variables
### using the lm() function, as shown in the previous section (OLS regression)

###############################

