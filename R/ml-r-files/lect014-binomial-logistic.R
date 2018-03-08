
###########################
### binomial logistic regression
###########################


bank <- read.csv("bankmarketing.csv")

View(bank)

### we will predict the chance that a subject creates a deposit
### based on the following variables:
### age, marital, default, education, balance, housing, loan and duration

### to run the logistic regression, we use the glm function

fit <- glm(deposit~age+marital+default+balance+housing+loan+duration, data=bank, family=binomial())

### to understand how the program recoded the categorical variables
### we can use the contrasts() function

contrasts(bank$deposit)   # no is the category of reference

contrasts(bank$housing)   # no is the category of reference

contrasts(bank$education)   # primary is the category of reference

### get the model indicators

summary(fit)

### Null deviance - the difference between the LL of the saturated model
### (the model where each case has its own parameter)
### and the LL of the null model (with intercept only)

### Residual deviance - difference between the LL of the 
### saturated model and the LL of the proposed model

### the proposed model is better than the saturated model
### because it has a lower LL

######### compute the antilogarithms of the coefficients
######### these antilogs actually represent the chance that a subject opens a deposit
######### they are useful for inference

expb <- exp(coef(fit))

expb

#####################################


