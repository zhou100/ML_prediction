
#######################
### pruning a regression tree
#######################


cp <- read.csv("company2.csv")

View(cp)

### we will prune the regression tree we have grown
### in the previous lecture, using the cost complexity method

### compute the prediction accuracy of the initial tree in the TEST set

pred <- predict(fit, cp_test)

mse <- sum((pred - cp_test$salary)^2)/237

var.y <- sum((cp_test$salary - mean(cp_test$salary))^2)/236

rsq <- 1 - mse/var.y

rsq

### print the complexity parameter table
### to identify the lower cross-validation error

printcp(fit)

### to prune the tree we use the prune() function

### this function has two main arguments:
### the tree (fit) and the complexity parameter value

### extract the cp value corresponding to
### the lowest cross-validation error (xerror)

ocp <- fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"]

ocp

### prune the tree

prfit <- prune(fit, ocp)

rpart.plot(prfit)

### compute the prediction accuracy for our simplified tree

prpred <- predict(prfit, cp_test)

mse <- sum((prpred - cp_test$salary)^2)/237

var.y <- sum((cp_test$salary - mean(cp_test$salary))^2)/236

pr_rsq <- 1 - mse/var.y

pr_rsq

### prune with a particular cp value
### to see whether we can get a good prediction accuracy
### with a less complex tree

printcp(fit)

prfit2 <- prune(fit, 0.03)

rpart.plot(prfit2)

### get the predicted values and compute the r squared

prpred2 <- predict(prfit2, cp_test)

mse <- sum((prpred2 - cp_test$salary)^2)/237

var.y <- sum((cp_test$salary - mean(cp_test$salary))^2)/236

rsq <- 1 - mse/var.y

rsq



