
##########################
### principal component analysis
##########################

ad <- read.csv("advert.csv")

View(ad)

### first we have to find the best (optimal) number of factors
### then we'll build our factor analysis model with this number

### we are going to use the correlation matrix to build our model

### to run the pca we use the princomp function in the stats package

pcamodel <- princomp(ad, cor=TRUE)

### print the standard deviations of the components (factors)

pcamodel

### print the standard deviations and the proportions of explained variance

summary(pcamodel)

### to choose the number of components we use the Kaiser criterion
### so we retain the components that have the eigenvalue higher than one

### the eigenvalues are the squared standard deviations of the components

### print the standard deviations

pcamodel$sdev

### compute and print the eigenvalues

eigenv <- pcamodel$sdev^2

eigenv

### based on the Kaiser criterion we decide to retain three factors

### run a factor analysis 
### using the optimal number of factors discovered at the previous step

### to perform the factor analysis we use the factanal function in the stats package

### we will also rotate the factors using the varimax rotation method

factmodel <- factanal(ad, factors = 3, rotation = "varimax")

### print the factor matrix, with a 0.3 cutoff
### (only the loadings greater than 0.3 will be shown)

print(factmodel, digits=2, cutoff=.3, sort=TRUE)


