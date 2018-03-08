
##############################
### lasso logistic regression
##############################

bank <- read.csv("bankmarketing.csv")

View(bank)

### we want to predict whether a customer will open a deposit or not
### based on these variables: 
### age, marital, default, education, balance, housing, loan and duration


### we will use the glmnet() function from the glmnet package

require(glmnet)

### create the matrices of the variables

x <- model.matrix(deposit~age+marital+default+balance+housing+loan+duration, bank)[,-1]

y <- bank$deposit


### create the set of lambda values as powers of 10

w <- seq(10, -3, length=100)

lvalues <- 10 ^ w

### fit the model

fit <- glmnet(x, y, alpha = 1, lambda = lvalues, family = "binomial")

### get a certain lambda value

fit$lambda[88]

### get the coefficients for this lambda value

coef(fit)[,88]

### get the non-zero coefficients

coef(fit)[,88][coef(fit)[,88]!=0]

###########################################


