

library(xtable)
library(ggplot2)
library(ggfortify)
library(caret)
library(AER)
library(gridExtra)
# source the functions 
source("code/functions/linear.R")
source("code/functions/mse_calculation.R")
source("code/functions/formula.R")


# Import the Malawi data. 

# import the data 
ihs2010<-read.csv("data/cleaned/Malawi/clust_2010.csv")
ihs2013<-read.csv("data/cleaned/Malawi/clust_2013.csv")

FCS_before<-read.csv("data/cleaned/Malawi/logFCS_predict_CLUST_before.csv")
lm_test_measure<-postResample(FCS_before[,1],FCS_before[,2])
lm_test_measure

FCS_after<-read.csv("data/cleaned/Malawi/logFCS_predict_CLUST_after.csv")
lm_test_measure_after<-postResample(FCS_after[,1],FCS_after[,2])
lm_test_measure_after



HDDS_before<-read.csv("data/cleaned/Malawi/HDDS_predict_CLUST_before.csv")
lm_test_measure<-postResample(HDDS_before[,1],HDDS_before[,2])
lm_test_measure

HDDS_after<-read.csv("data/cleaned/Malawi/HDDS_predict_CLUST_after.csv")
lm_test_measure_after<-postResample(HDDS_after[,1],HDDS_after[,2])
lm_test_measure_after



RCSI_before<-read.csv("data/cleaned/Malawi/RCSI_predict_CLUST_before.csv")
lm_test_measure<-postResample(HDDS_before[,1],HDDS_before[,2])
lm_test_measure

RCSI_after<-read.csv("data/cleaned/Malawi/RCSI_predict_CLUST_after.csv")
lm_test_measure_after<-postResample(HDDS_after[,1],HDDS_after[,2])
lm_test_measure_after




lm_test_measure

# Organize the variable names and ready for analysis. 

# levels 
levels<-c("ipczone","TA","clust")

# variables 
weather<-c("L12raincytot","L12day1rain","L12maxdays","floodmax")
access<-c("lag_price","lag_thinn")
asset1 <-c("roof","cells_own")
land<-c("percent_ag","elevation","nutri_reten_constrained")
distance<-c("dist_road","dist_admarc")
demo<-c("hhsize","hh_age","hh_gender","asset")

model3_variables<-c(weather,access,asset1,land,distance,demo)
model2_variables<-c(weather,access,asset1,land,distance)
model1_variables<-c(weather,access,land,distance)

# goal : combine variables at different levels using pastes 
# output: variables lists at different levels, TA_vars, ipczone vars, etc. 

for (level in levels){
  # assign levels of variables group
  group_var_name<-paste(level,"vars",sep="_")
  assign(group_var_name,c())
  
  for(var in model3_variables){
    temp<-paste(level,var,sep = "_")
    new<-append(get(group_var_name),temp)
    assign(group_var_name,new)
  }
}
 

### 1. Linear/tobit Results 

# Create the formulas using the formula_compose function. 

rcsi_formula<-formula_compose("RCSI",clust_vars)
logFCS_formula<-formula_compose("logFCS",clust_vars)
HDDS_formula<-formula_compose("HDDS",clust_vars)

rcsi_predictions<-linear_fit(rcsi_formula,ihs2010,ihs2013)
# lm_train_measure<-postResample(rcsi_predictions$pred_train,ihs2010$RCSI)
lm_test_measure<-postResample(rcsi_predictions$pred_test,ihs2013$RCSI)
lm_test_measure
# scatter.smooth(rcsi_predictions$pred_test,ihs2013$RCSI)

# try tobit instead for RCSI. The prediction value (unconditional mean) should actually be different with the assumption of non-normal / Gaussian error.  The old predication function returns a latent mean.

tobit_rcsi<-tobit(rcsi_formula,left = 0,right = Inf,data =ihs2010)
mu <- predict(tobit_rcsi,newdata= ihs2013)
sigma <- tobit_rcsi$scale
p0 <- pnorm(mu/sigma)
lambda <- function(x) dnorm(x)/pnorm(x)
ey0 <- mu + sigma * lambda(mu/sigma)
ey <- p0 * ey0
RCSI_tobit_prediction<-ey

#There are some improvement but still slighlty 

lm_test_measure<-postResample(RCSI_tobit_prediction,ihs2013$RCSI)
lm_test_measure
scatter.smooth(RCSI_tobit_prediction,ihs2013$RCSI)

logFCS_predictions<-linear_fit(logFCS_formula,ihs2010,ihs2013)
lm_test_measure<-postResample(rcsi_predictions$pred_test,ihs2013$logFCS)
lm_test_measure
# scatter.smooth(logFCS_predictions$pred_test,ihs2013$logFCS)

HDDS_predictions<-linear_fit(HDDS_formula,ihs2010,ihs2013)
lm_test_measure<-postResample(rcsi_predictions$pred_test,ihs2013$HDDS)
lm_test_measure
# scatter.smooth(HDDS_predictions$pred_test,ihs2013$HDDS)
