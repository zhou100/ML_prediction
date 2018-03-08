
############################################
### using neural networks in predictive analysis (2)
############################################

### we will try various settings for our neural network,
### with the hope to improve the prediction accuracy in the test set

### build the neural network

formula <- churn~tenure+age+income+educ+members

########### change the number of nodes in the hidden layer

net1 <- neuralnet(formula, phone_train, algorithm = "rprop-", hidden = 5,
                 err.fct = "sse", act.fct = "logistic", rep = 1, stepmax = 1e06,
                 threshold = 0.01, linear.output = FALSE)

### make predictions in the test set

pred <- compute(net1, phone_test[,-6])

pred2 <- pred$net.result

predcat <- ifelse(pred2<0.5, 0, 1)

mean(predcat == phone_test$churn)

########### change the backpropagation algorithm

net2 <- neuralnet(formula, phone_train, algorithm = "rprop+", hidden = 5,
                 err.fct = "sse", act.fct = "logistic", rep = 1, stepmax = 1e06,
                 threshold = 0.01, linear.output = FALSE)

### make predictions in the test set

pred <- compute(net2, phone_test[,-6])

pred2 <- pred$net.result

predcat <- ifelse(pred2<0.5, 0, 1)

mean(predcat == phone_test$churn)

########### change the algorithm and the activation function

net3 <- neuralnet(formula, phone_train, algorithm = "rprop+", hidden = 5,
                 err.fct = "sse", act.fct = "tanh", rep = 1, stepmax = 1e06,
                 linear.output = FALSE, threshold = 0.01)

### make predictions

pred <- compute(net3, phone_test[,-6])

pred2 <- pred$net.result

predcat <- ifelse(pred2<0.5, 0, 1)

mean(predcat == phone_test$churn)

