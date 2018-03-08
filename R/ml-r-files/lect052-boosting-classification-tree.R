
#############################
### boosting classification trees
#############################

phone <- read.csv("phone.csv")

View(phone)

### we have to predict whether a customer will abandon the company
### the target variable is churn (1 - yes, 0 - no)
### the predictors are tenure, age, income, education and family members

### load the gbm package

require(gbm)

### create the training set and the test set

i <- sample(1000, 500)

phone_train <- phone[i,]

phone_test <- phone[-i,]

### perform boosting

boost.fit <- gbm(churn~., data = phone_train, 
                 distribution = "bernoulli", n.trees = 5000, interaction.depth = 3,
                 shrinkage = 0.01)

### for the classification trees, the distribution parameter is set to bernoulli
### the n.trees parameter controls the number of trees

### the interaction.depth parameter controls the number of nodes in each tree

### 0.01 is the recommended value for the shrinkage parameter (learning rate)

### print the summary output

summary(boost.fit)

### compute the prediction accuracy in the test set

boost.pred <- predict(boost.fit, phone_test, n.trees = 5000, type = "response")

head(boost.pred)

### round the probabilities

boost.pred <- round(predict(boost.fit, phone_test, n.trees = 5000, type = "response"))

head(boost.pred)

mean(boost.pred == phone_test$churn)

### goodness-of-fit on the training set

boost.pred2 <- round(predict(boost.fit, phone_train, n.trees = 5000, type = "response"))

mean(boost.pred2 == phone_train$churn)

### find the optimal shrinkage parameter

k <- -10:-1

shrink <- 10 ^ k

vect_acc <- c()

for (j in shrink)  {
  
  boost.fit <- gbm(churn~., data = phone_train, 
                   distribution = "bernoulli", n.trees = 5000, interaction.depth = 3,
                   shrinkage = j)
  
  boost.pred <- round(predict(boost.fit, phone_test, n.trees = 5000, type = "response"))
  
  acc <- mean(boost.pred == phone_test$churn)
  
  vect_acc <- c(vect_acc, acc)
  
}

which.max(vect_acc)

max(vect_acc)

shrink[which.max(vect_acc)]


