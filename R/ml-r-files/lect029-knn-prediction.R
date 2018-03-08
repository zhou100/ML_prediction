
##################
## k nearest neighbor
##################

phone <- read.csv("phone.csv")

phone <- phone[complete.cases(phone),]

View(phone)

### we will predict whether the customer will abandon the company or not
### based on the following variables: tenure, age, income

### the dependent variable is churn, with the values 1 (yes) and 0 (no)

### prepare the data

### standardize the predictors

phone2 <- data.frame(scale(phone[1:3]))

View(phone2)

### add the target variable to the data set phone2

phone2 <- cbind(phone2, churn = phone$churn)

### create the training set and the test set

i <- sample(1000, 500)

phone2_train <- phone2[i,]

phone2_test <- phone2[-i,]

### define the target variable in the training set

churn <- phone2_train$churn

head(churn,20)

### to apply the knn algorithm we will use
### the knn function in the class package

require(class)

### get the predicted values using the knn classifier

### in the knn function we have to specify:

### the predictors in the training set (train)
### the predictors in the test set (test)
### the response variable values in the training set (cl)
### the number of neighbors (k)

pred <- knn(train = phone2_train[,-4], test = phone2_test[,-4], cl = churn, k = 10)

head(pred,20)

### get the prediction accuracy in the test set

mean(pred == phone2_test$churn)

### use the model for predictions on new customers

### simulate new data (customer)

tenure <- 40

age <- 25

income <- 65

newdata <- data.frame(tenure, age, income)

### predict whether they will abandon

pred <- knn(train = phone2_train[,-4], test = newdata, cl = churn, k = 10)

pred
