
#################
# validating the OLS regression
# using the validation set approach
#################

cars <- read.csv("carsales.csv")

View(cars)

### we randomly split the cars data frame into a training set and a test set
### each of them will contain about 50% of the data

### we are interested if the model fitted on the training set 
### performs well on the test set too

### extract 77 random numbers from 1 to 155 (77 is approximately the half of 155)

n <- sample(155, 77)

n

### the n vector will provide the indices for the training set

### create the training set

cars_train <- cars[n,]

View(cars_train)

### create the test (validation) set

cars_test <- cars[-n,]

View(cars_test)

### now we fit the data using the TRAINING set

fit <- lm(price~engine+horse+weight, data = cars_train)

### compute the TRAINING set mse

pred <- predict(fit)

train_mse <- mean((cars_train$price - pred)^2)

train_mse

### compute the TEST set mse

pred2 <- predict(fit, cars_test)

head(pred2)

test_mse <- mean((cars_test$price - pred2)^2)

test_mse

#######################################

