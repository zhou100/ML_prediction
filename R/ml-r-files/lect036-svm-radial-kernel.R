
####################
## support vector machine
## radial kernel
####################

phone <- read.csv("phone.csv")

View(phone)

### we will predict whether a customer will abandon the company
### based on the following predictors:
### tenure, age, income, education, number of family members

### we will use the svm function in the e1071 package

require(e1071)

### create the training set and the test set

i <- sample(1000, 500)

phone_train <- phone[i,]

phone_test <- phone[-i,]

### fit the svm model

fit <- svm(churn~., data = phone_train,
           type = "C-classification", kernel = "radial", cost = 4, gamma = 0.112)

###  compute the prediction accuracy in the test set

pred <- predict(fit, phone_test)

mean(pred == phone_test$churn)


### try to find the best cost and gamma (improve the prediction accuracy)
### perform 10-fold cross-validation with the tune.svm function

t_radi <- tune.svm(churn~., data = phone_train, cost = 2^(2:5), kernel = "radial",
              gamma = seq(0.001, 1, length = 10))

t_radi$best.parameters


