
##########################
### bagging a classification tree
##########################

phone <- read.csv("phone.csv")

View(phone)

### we have to predict whether a customer will abandon the company
### the target variable is churn (1 - yes, 0 - no)
### the predictors are tenure, age, income, education and family members

require(randomForest)

### create the trainig set and the test set

i <- sample(1000, 500)

phone_train <- phone[i,]

phone_test <- phone[-i,]

### perform bagging

bag.fit <- randomForest(factor(churn)~., data = phone_train, mtry = 5)

### the target variable churn is converted into a factor
### so the program knows that we build classification trees

### mtry indicates the number of predictors in each tree
### in this case itis equal to the total number of predictors

### the default number of trees is 500
### we can use the ntree parameter to set the number of trees

### compute the prediction accuracy in the test set

bag.pred <- predict(bag.fit, phone_test)

head(bag.pred)

mean(bag.pred == phone_test$churn)

### compute the prediction accuracy in the training set

bag.pred2 <- predict(bag.fit, phone_train)

mean(bag.pred2 == phone_train$churn)


