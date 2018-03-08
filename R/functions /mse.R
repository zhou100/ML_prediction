mse_calculation <- function(formula, train_data,test_data){
  
  # Goals
  #   (1) fit a linear function based on a training set and a testing set 
  
  # Inputs
  #   (1) formula: formula of y on the x variables 
  #   (2) train_data: dataframe containing both label and features 
  #   (3) test_data: dataframe containing both label and features
  
  # Outputs
  #   (1) dataframe containing 
  
  mse <- mean((cars_train$price - pred)^2)
  
  return(mse)
}
