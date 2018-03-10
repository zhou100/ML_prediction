library(caret)
library(rlist)


# import the data 
ihs2010<-read.csv("data/cleaned/Malawi/IHS2010.csv")
ihs2013<-read.csv("data/cleaned/Malawi/IHS2013.csv")

# source the functions 


source("code/linear.R")
source("code/mse_calculation.R")


# iv_string <- paste(ivs, collapse=" + ")
# regression_formula <- as.formula(paste(dv, iv_string, sep=" ~ "))

# foreach level of varlist {
#   local `level'_weather `level'_L12raincytot  `level'_L12day1rain `level'_L12maxdays `level'_floodmax
#   local `level'_lagmkt `level'_lag_price `level'_lag_thinn 
#   local `level'_mkt `level'_price `level'_thinn 
#   local `level'_asset1 `level'_roof `level'_cells_own
#   local `level'_land `level'_percent_ag  `level'_elevation  
#   local `level'_nutri  `level'_nutri_reten_constrained
#   local `level'_dist `level'_dist_road `level'_dist_admarc 
#   local `level'_demo `level'_hhsize `level'_hh_age `level'_hh_gender `level'_asset 
# }

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


# combine variables at different levels using pastes 
for (level in levels){
  # assign levels of variables group
  group_var_name<-paste(level,"vars",sep="_")
  assign(group_var_name,c())
  
  for(var in variables){
    temp<-paste(level,var,sep = "_")
    new<-append(get(group_var_name),temp)
    assign(group_var_name,new)
  }
}

# do the model 3 variables first 

# TA_vars formula 

TA_formula<-paste(TA_vars,collapse = "+")
ipczone_formula<-paste(ipczone_vars,collapse = "+")
clust_formula<-paste(clust_vars,collapse = "+")



as.data.frame(rain)

linear_fit(,ihs2010,ihs2013)

# perform a linear 

