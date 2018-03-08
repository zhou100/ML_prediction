
formula_compose <- function(y_name,x_name){
  
  # Goals
  #   (1) compose a formula for implementing models in R.
  
  # Inputs
  #   (1) y_name: formula of y on the x variables 
  #   (2) x_name: dataframe containing both label and features 

  
  # Outputs
  #   (1) a dataframe containing the predicated value of y variable in the training and testing set. 
  
  # fit the model on the training data 
  lm_fit <- lm(formula = lm_formula, data = train_data)
  
  # predict training values
  pred_train <- predict(fit)
  
  ### compute the TEST predication 
  pred_test <- predict(lm_fit, test_data)
  
  return(pred_train,pred_test)
}

