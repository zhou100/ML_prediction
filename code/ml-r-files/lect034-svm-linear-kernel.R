
####################
## support vector machine
## linear kernel
####################

phone <- read.csv("phone.csv")

View(phone)

### we will predict whether a customer will abandon the company
### based on the following predictors:
### tenure, age, income, education, number of family members

### the target variable is churn, with the values 1 (yes) and 0 (no)

### we will use the svm function in the e1071 package

require(e1071)

### create the training set and the test set

i <- sample(1000, 500)

phone_train <- phone[i,]

phone_test <- phone[-i,]

### fit the svm model in the training set

fit <- svm(churn~., data = phone_train,
           type = "C-classification", kernel = "linear", cost = 256)

### the value of the parameter type, C-classfication,
### indicates that we use the model for classification
### (our dependent variable is categorical)

### the default cost value is 1

###  compute the prediction accuracy in the test set

pred <- predict(fit, phone_test)

mean(pred == phone_test$churn)

### try to find the best cost (improve the prediction accuracy)
### perform 10-fold cross-validation with the tune.svm function

t_lin <- tune.svm(churn~., data = phone_train, cost = 2^(2:8), kernel = "linear")

t_lin$best.parameters




