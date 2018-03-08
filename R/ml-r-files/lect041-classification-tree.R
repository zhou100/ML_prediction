
##########################
### growing a classification tree
##########################

phone <- read.csv("phone.csv")

View(phone)

### we will predict whether a customer will abandon the company
### the target variable is churn (1 - yes, 0 - no)
### the predictors are tenure, age, income, education and family members

require(rpart)

require(rpart.plot)

### create the training set and the test set

i <- sample(1000, 500)

phone_train <- phone[i,]

phone_test <- phone[-i,]

### grow the classification tree with the rpart() function
### the method parameter must be set to "class"

fit <- rpart(churn~., data = phone_train, method = "class")

### plot the tree

prp(fit)

rpart.plot(fit)

### print the CP table

printcp(fit)

### compute the predictive accuracy in the training set
### the type parameter must be set to "class"

pred <- predict(fit, phone_train, type = "class")

mean(pred == phone_train$churn)

### compute the predictive accuracy in the test set

pred2 <- predict(fit, phone_test, type = "class")

mean(pred2 == phone_test$churn)

