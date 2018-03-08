
############################################
### using neural network in predictive analysis (1)
############################################

phone <- read.csv("phone.csv")

View(phone)

### create the training set and the test set

n <- sample(1000, 500)

phone_train <- phone[n,]

phone_test <- phone[-n,]

### train the network

require(neuralnet)

### create the formula

formula <- churn~tenure+age+income+educ+members

class(formula)

net <- neuralnet(formula, phone_train, algorithm = "rprop-", hidden = 10,
                 err.fct = "sse", act.fct = "logistic", rep = 1, stepmax = 1e06,
                 threshold = 0.01, linear.output = FALSE)

### plot the neural network

plot(net)

### plot the neural network without weights

plot(net, show.weights = FALSE)

### generate the main results

net$result.matrix

### generate the weights list

net$weights

### make predictions in the test set

pred <- compute(net, phone_test[,-6])

pred2 <- pred$net.result

head(pred2, 5)

### create a categorical predicted value

predcat <- ifelse(pred2<0.5, 0, 1)

### build the classification table

table(predcat, phone_test$churn)

### compute the predictive accuracy

mean(predcat == phone_test$churn)


