
#######################
### growing a regression tree
#######################

cp <- read.csv("company2.csv")

View(cp)

### we will predict the employees' salaries
### based on the following independent variables:
### gender, education level, job and job time

require(rpart)

require(rpart.plot)

### create the training set and the test set

i <- sample(474, 237)

cp_train <- cp[i, 1:5]

cp_test <- cp[-i, 1:5]

### grow the regression tree with the rpart() function
### the method parameter must be set to "anova" 

### the rpart() function has built-in cross validation
### it performs a 10-fold cross-validation

fit <- rpart(salary~., data = cp_train, method = "anova")

### plot the tree with the prp() function

prp(fit)

### plot the tree with the rpart.plot() function

rpart.plot(fit)

### print the complexity parameter table

printcp(fit)

### compute the goodness-of-fit in the training set

pred <- predict(fit, cp_train)

pred[1:10]

mse <- sum((pred - cp_train$salary)^2)/237

var.y <- sum((cp_train$salary - mean(cp_train$salary))^2)/236

rsq <- 1 - mse/var.y

rsq

### compute the goodness-of-fit in the TEST set

pred2 <- predict(fit, cp_test)

mse <- sum((pred2 - cp_test$salary)^2)/237

var.y <- sum((cp_test$salary - mean(cp_test$salary))^2)/236

rsq <- 1 - mse/var.y

rsq


