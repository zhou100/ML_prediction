
##################################
### random forest of regression trees
##################################

cp <- read.csv("company2.csv")

View(cp)

### we have to predict the employees' salaries
### based on the following independent variables:
### gender, education level, job and job time

### load the randomForest package

require(randomForest)

### create the validation set and the test set

i <- sample(474, 237)

cp_train <- cp[i, 1:5]

cp_test <- cp[-i, 1:5]

### fit the random forest

rf.fit <- randomForest(salary~., data = cp_train, mtry = 2)

### the mtry parameter indicates 
### the number of predictors in each tree

### for a regression tree, this number is equal to the
### half of the total number of predictors

### the default number of trees is 500
### to change the number of trees we can use the ntree option

### compute the prediction accuracy in the test set

rf.pred <- predict(rf.fit, cp_test)

head(rf.pred)

### goodness-of-fit on the test set

mse <- sum((rf.pred - cp_test$salary)^2)/237

var.y <- sum((cp_test$salary - mean(cp_test$salary))^2)/236

rsq <- 1 - mse/var.y

rsq

### goodness-of-fit in the training set

rf.pred2 <- predict(rf.fit, cp_train)

mse <- sum((rf.pred2 - cp_train$salary)^2)/237

var.y <- sum((cp_train$salary - mean(cp_train$salary))^2)/236

rsq <- 1 - mse/var.y

rsq


