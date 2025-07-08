library(plumber)
library(rpart)

getwd()

# Load the pre-trained model
plumber_model <- readRDS("./05_model/tree_model.rds")

#* @post /predict
#* @param region character
#* @param soil_type character
#* @param crop character
#* @param rainfall_mm numeric
#* @param temperature_celsius numeric
#* @param fertilizer_used character
#* @param irrigation_used character
#* @param weather_condition character
#* @param days_to_harvest numeric
#* @return JSON object containing predicted yield
function(region, soil_type, crop, rainfall_mm, temperature_celsius, fertilizer_used, irrigation_used, weather_condition, days_to_harvest) {
  
  # Create the new data frame with all input features
  new_data <- data.frame(
    region = as.character(region),
    soil_type = as.character(soil_type),
    crop = as.character(crop),
    rainfall_mm = as.numeric(rainfall_mm),
    temperature_celsius = as.numeric(temperature_celsius),
    fertilizer_used = as.character(fertilizer_used),
    irrigation_used = as.character(irrigation_used),
    weather_condition = as.character(weather_condition),
    days_to_harvest = as.numeric(days_to_harvest)
  )
  
  # Use the loaded model to make the prediction
  prediction <- predict(plumber_model, new_data)
  
  # Return the predicted yield as JSON
  return(list(predicted_yield = round(prediction, 2)))
}

# Run the Plumber API on port 8000
r <- plumb("plumber.R")
r$run(port = 8000)


# curl -X POST "http://localhost:8000/predict" \
# -d "region=North" \
# -d "soil_type=Loamy" \
# -d "crop=Wheat" \
# -d "rainfall_mm=120" \
# -d "temperature_celsius=25" \
# -d "fertilizer_used=Yes" \
# -d "irrigation_used=Yes" \
# -d "weather_condition=Sunny" \
# -d "days_to_harvest=120"
