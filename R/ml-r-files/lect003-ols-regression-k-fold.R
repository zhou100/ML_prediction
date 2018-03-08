
#################
# validating the OLS regression
# using the k-fold cross-validation technique
#################

cars <- read.csv("carsales.csv")

View(cars)

### to perform th k-fold cross-validation 
### we will use the cv.lm() function in the DAAG package

require(DAAG)

fit <- cv.lm(data=cars, form.lm=formula(price~engine+horse+weight), m=10)

### m is the number of folds

### the output (fit) is a data frame, NOT a list

View(fit)

### Predicted is the predicted value of the price on the entire data set

### cvpred is the average predicted value for each case (using k-fold)

### the test set mse was automatically computed

### it is one of the data frame's attributes

attributes(fit)

### we can also compute the test set mse by hand, just to cross-check

mse <- mean((fit$cvpred - fit$price)^2)

mse


##############################

