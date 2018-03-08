
#######################
### bagging a regression tree
#######################

cp <- read.csv("company2.csv")

View(cp)

### we have to predict the employees' salaries
### based on the following independent variables:
### gender, education level, job category and job time

### to perform bagging we use the randomForest package

require(randomForest)

### create the validation set and the test set

i <- sample(474, 237)

cp_train <- cp[i, 1:5]

cp_test <- cp[-i, 1:5]

### perform bagging using the training set

bag.fit <- randomForest(salary~., data = cp_train, mtry = 4)

### the mtry parameter indicates 
### the number of predictors in each tree
### in bagging, it is equal with the total number of predictors
### (each tree uses all predictors)

### the default number of trees is 500
### to change the number of trees we can use the ntree option

### prediction accuracy in the test set

bag.pred <- predict(bag.fit, cp_test)

head(bag.pred)

mse <- sum((bag.pred - cp_test$salary)^2)/237

var.y <- sum((cp_test$salary - mean(cp_test$salary))^2)/236

rsq <- 1 - mse/var.y

rsq

### goodness-of-fit on the training set

bag.pred2 <- predict(bag.fit, cp_train)

mse <- sum((bag.pred2 - cp_train$salary)^2)/237

var.y <- sum((cp_train$salary - mean(cp_train$salary))^2)/236

rsq <- 1 - mse/var.y

rsq

 

