
##########################
### simple neural network example 
##########################

### simulate the predictors
### they are normal random variables 
### with the mean of 0 and standard deviation of 3

a <- rnorm(500, 0, 3)

b <- rnorm(500, 0, 3)

### simulate the output (target variable)

### it is a dichotomous variable with the following values:
### 1 if the product of a and b is positive
### 0 if the product of a and b is negative

c <- a * b

output <- ifelse(c>=0, 1, 0)

### our neural network will learn to predict the output value
### (1 or 0) knowing the values of a and b 

### create a data frame with our variables

dat <- data.frame(a, b, output)

View(dat)

### create the training set and the test set

j <- sample(500, 250)

dat_train <- dat[j,]

dat_test <- dat[-j,]

### train the neural network

require(neuralnet)

net <- neuralnet(output~a+b, dat_train, hidden = 10, algorithm = "rprop+",
                 err.fct = "sse", act.fct = "logistic", rep = 1, stepmax = 1e06,
                 threshold = 0.01, linear.output = FALSE)

### there are two algorithms commonly used for backpropagation

### resilient backpropagation with weights backtracking (rprop+)
### resilient backpropagation without weights backtracking (rprop-)

### plot the neural network

plot(net)

### plot the neural network without weights

plot(net, show.weights = FALSE)

### generate the main results

net$result.matrix

### generate the weights list

net$weights

### make predictions in the test set
### using the compute function

pred <- compute(net, dat_test[,-3])

pred2 <- pred$net.result

head(pred2, 5)

### create a categorical predicted value

predcat <- ifelse(pred2<0.5, 0, 1)

### create the classification (confusion) table 

table(predcat, dat_test$output)

mean(predcat == dat_test$output)

### predict the output with new data

newd <- data.frame(a=-0.3, b=-1.1)

pred <- compute(net, newd)

pred2 <- pred$net.result

pred2


