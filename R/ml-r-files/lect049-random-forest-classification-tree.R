
#######################################
### random forest of classification trees
#######################################

phone <- read.csv("phone.csv")

View(phone)

### we have to predict whether a customer will abandon the company
### the target variable is churn (1 - yes, 0 - no)
### the predictors are tenure, age, income, education and family members

### load the randomForest package

require(randomForest)

### create the validation set and the test set

i <- sample(1000, 500)

phone_train <- phone[i,]

phone_test <- phone[-i,]

### grow the random forest

rf.fit <- randomForest(factor(churn)~., data = phone_train, mtry = 2)

### the target variable churn is converted into a factor
### so the program knows that we build classification trees

### the mtry parameter indicates 
### the number of predictors in each tree

### for a classification tree, this number is approximately equal
### to the square root of the total number of predictors

### the default number of trees is 500
### to change the number of trees we can use the ntree option

### compute the prediction accuracy in the test set

rf.pred <- predict(rf.fit, phone_test)

head(rf.pred)

mean(rf.pred == phone_test$churn)

### compute the prediction accuracy in the training set

rf.pred2 <- predict(rf.fit, phone_train)

mean(rf.pred2 == phone_train$churn)


