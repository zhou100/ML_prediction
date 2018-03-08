
##########################
# backward stepwise selection
##########################



### in the regusbsets function we must set the method parameter to "backward"

fit <- regsubsets(burglPerPop~., crim2, nvmax = 16, method="backward")

summ <- summary(fit)

summ

### get the adjusted R squared

summ$adjr2

which.max(summ$adjr2)

coef(fit, 12)

######################################

