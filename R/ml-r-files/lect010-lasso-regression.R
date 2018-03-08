
###########################
# lasso regression
##########################


crim <- read.csv("commcrime.csv")

crim2 <- crim[complete.cases(crim),]

View(crim2)

### we will use again the glmnet() function in the glmnet package

require(glmnet)

### this time, the alpha parameter will be set to 1

### create the matrices of the variables
### (please see the lecture about ridge regression for explanations)

x <- model.matrix(burglPerPop~., crim2)[,-1]

y <- crim2$burglPerPop

### create the set of lambda values

w <- seq(10, -3, length=100)

lvalues <- 10 ^ w

### fit the model

fit <- glmnet(x, y, alpha = 1, lambda = lvalues)


### a model with a high lambda value

fit$lambda[3]

coef(fit)[,3]


### a model with a low lambda value

fit$lambda[99]

coef(fit)[,99]


### a model with an intermediate lambda value

fit$lambda[70]

coef(fit)[,70]

### to get the coefficients that are different from zero

coef(fit)[,70][coef(fit)[,70]!=0]

##########################################


