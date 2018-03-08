mse_calculation <- function(true_value, predict_value){
  
  # Goals
  #   (1) fit a linear function based on a training set and a testing set 
  
  # Inputs
  #   (1) formula: formula of y on the x variables 
  #   (2) train_data: dataframe containing both label and features 
  #   (3) test_data: dataframe containing both label and features
  
  # Outputs
  #   (1) mse: a value of measuring accuracy 
  
  mse <- mean((true_value - predict_value)^2)
  
  return(mse)
}
