
#####################
# forward stepwise selection
#####################



######### forward selection

### in the regsubsets function we must set the method parameter to "forward"

fit <- regsubsets(burglPerPop~., crim2, nvmax = 16, method="forward")

summ <- summary(fit)

summ

### we will use the adjusted R squared to assess the goodness-of-fit

summ$adjr2

which.max(summ$adjr2)

### get the coefficients for the best model

coef(fit, 13)

### if we are interested in interpretability, we can choose a more parcimonious model
### for example a model with 9 variables

coef(fit, 9)

#######################################

