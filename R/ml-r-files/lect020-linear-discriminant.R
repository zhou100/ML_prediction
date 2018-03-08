
###########################
### linear discriminant analysis
###########################


bank <- read.csv("bankmarketing.csv")

View(bank)

### we want to predict whether a customer will create a deposit or not
### using three variables: age, balance and duration of contact

### we wil use the lda() function in the MASS package

require(MASS)

fit <- lda(deposit~age+balance+duration, data = bank)

### get the coefficients of the linear discriminant function

fit

### compute the prediction accuracy

pred <- predict(fit)  # get the list of predicted values

head(pred)

class <- pred$class  # get the estimated class for each case

head(class)

### build the classification table

table(bank$deposit, class)

### comput the number of correctly classified cases

correct <- mean(bank$deposit == class)

correct

######################################

