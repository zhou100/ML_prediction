
#########################################
### principal components analysis - adequacy tests
#########################################

ad <- read.csv("advert.csv")

View(ad)

### how to compute the Kaiser-Meier-Olkin measure 
### and the Bartlett's sphericity test

### get the correlation matrix for our variables

cormatrix <- cor(ad)

View(cormatrix)

#### compute the KMO indicator
### using the KMO function in the psych package

require(psych)

KMO(cormatrix)

### the argument can be the data frame as well

KMO(ad)

### compute the Bartlett's test

cortest.bartlett(cormatrix, 369)   

### 369 is the sample size (number of respondents)
### 100 is the default
### the sample size must be specified only when the argument is a matrix

### if the argument is a data frame, we don't have to specify the sample size

cortest.bartlett(ad)

