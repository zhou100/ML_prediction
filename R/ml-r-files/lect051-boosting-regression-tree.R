
##########################
### boosting regression trees
##########################

cp <- read.csv("company2.csv")

View(cp)

### we have to predict the employees' salaries
### based on the following independent variables:
### gender, education level, job and job time

### load the gbm package

require(gbm)

### create the validation set and the test set

i <- sample(474, 237)

cp_train <- cp[i, 1:5]

cp_test <- cp[-i, 1:5]

### perform boosting

boost.fit <- gbm(salary~., data = cp_train, 
            distribution = "gaussian", interaction.depth = 3, n.trees = 5000,
            shrinkage = 0.01)

### for the regression trees, the distribution parameter is set to gaussian
### the n.trees parameter controls the number of trees

### the interaction.depth parameter controls the number of nodes in each tree

### 0.01 is the recommended value for the shrinkage parameter (learning rate)

### print the summary output

summary(boost.fit)

### the boosting technique can be also used for variable selection
### it indicates the relative influence (importance) of each predictor

### compute the prediction accuracy in the test set

boost.pred <- predict(boost.fit, cp_test, n.trees = 5000)

mse <- sum((boost.pred - cp_test$salary)^2)/237

var.y <- sum((cp_test$salary - mean(cp_test$salary))^2)/236

rsq <- 1 - mse/var.y

rsq

### compute the prediction accuracy in the training set

boost.pred2 <- predict(boost.fit, cp_train, n.trees = 5000)

mse <- sum((boost.pred2 - cp_train$salary)^2)/237

var.y <- sum((cp_train$salary - mean(cp_train$salary))^2)/236

rsq <- 1 - mse/var.y

rsq

