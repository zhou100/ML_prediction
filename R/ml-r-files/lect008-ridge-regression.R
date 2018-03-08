
#####################
# ridge regression
#####################


crim <- read.csv("commcrime.csv")

crim2 <- crim[complete.cases(crim),]

View(crim2)

### we will use the glmnet() function in the glmnet package

require(glmnet)

### before introducing our data in the glmnet() function
### we have to create a matrix and a vector

x <- model.matrix(burglPerPop~., crim2)[,-1]  # matrix of the predictors values

### the function model.matrix creates a design matrix to store the values
### of the independent variables (predictors)

### we added the [,-1] index to remove the first column of the matrix
### which only contains the 1 value

y <- crim2$burglPerPop  # vector of the dependent variable values

### next, we create the set of lambda values
### these values will be powers of 10

w <- seq(10, -3, length=100)

lvalues <- 10 ^ w

lvalues

### now we can fit the ridge regression model

fit <- glmnet(x, y, alpha = 0, lambda = lvalues)

### to get a ridge regression, the alpha parameter was set to zero

### to get the lambda values vector again we can run the following

fit$lambda

### to get the lambda value for a specified model

fit$lambda[40]

### to get the coefficients for the same model

coef(fit)[,40]

### we notice that none of the coefficients is exactly zero
### (the ridge regression does not perform variable selection)

### get the coefficients for a particular value of lambda
### (which is not in the vector of lambdas)

### for example, lambda = 1200

predict(fit, s = 1200, type = "coefficients")

#################################################

