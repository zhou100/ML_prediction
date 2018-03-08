library(caret)

# import the data 
ihs2010<-read.csv("data/cleaned/Malawi/IHS2010.csv")
ihs2013<-read.csv("data/cleaned/Malawi/IHS2013.csv")

# source the functions 

source('~/Box Sync/Research/ML_prediction/R/functions/mse_calculation.R', echo=TRUE)
source("/R/functions/mse_calculation.R")

# perform a linear 

setwd("/R/functions")