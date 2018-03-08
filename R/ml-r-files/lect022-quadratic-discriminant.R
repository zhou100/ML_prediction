
###############################
### quadratic discriminant analysis
##############################


bank <- read.csv("bankmarketing.csv")

View(bank)

### we want to predict whether a customer will create a deposit or not
### using three variables: age, balance and duration of contact

### we wil use the qda() function in the MASS package

require(MASS)

fit <- qda(deposit~age+balance+duration, data = bank)

### estimate the number of correctly classified cases

pred <- predict(fit)

estclass <- pred$class

head(estclass)

correct <- mean(estclass == bank$deposit)

correct

##########################################

