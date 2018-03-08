
#########
### the OLS regression
#########

cars <- read.csv("carsales.csv")

View(cars)

### dependent variable: car price (price)
### explainers: engine size (engine), horse power (horse) and curb weight (weight)

### we will use the lm() function in the stats package

### how to get the goodness-of-fit (adjusted R squared)
### the F-statistic and the regression coefficients

fit <- lm(price~engine+horse+weight, data = cars)

summary(fit)

### how to compute the mean squared error (MSE)

pred <- predict(fit)

head(pred)

mse <- mean((cars$price - pred)^2)

mse


########################



