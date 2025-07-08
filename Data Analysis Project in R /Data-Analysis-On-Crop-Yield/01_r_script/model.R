
# import data 
data <- read.csv("./00_raw_data/crop_yield.csv",  header = T)

# data cleaning
library(janitor)
data <- data %>% clean_names()
 
# check for duplicates
sum(duplicated(data))

# check for NA's
colnames(data)[apply(data, 2, anyNA)]

# check the structure of the data
str(data)

# data modelling
# preprocess the data

# encode the target variable
data[, 'fertilizer_used'] <- as.factor(data[, 'fertilizer_used'])

# check the levels of the target variable
levels(data$fertilizer_used)

# assign numeric levels to each
data$fertilizer_application <- as.numeric(factor(data$fertilizer_used, levels = 
                                            levels(data$fertilizer_used)))

# feature engineering
preprocess_data <- function(data) {
  # convert variables to numeric
  data$region <- as.numeric(factor(data$region))
  data$soil_type <- as.numeric(factor(data$soil_type))
  data$crop <- as.numeric(factor(data$crop))
  data$irrigation_used <- as.numeric(factor(data$irrigation_used))
  data$weather_condition <- as.numeric(factor(data$weather_condition))
  
  return(data)
}

# prepare data for modeling
processed_data <- preprocess_data(data)

# select the features
features <- c('region', 'soil_type', 'crop', 'rainfall_mm', 'temperature_celsius',
              'irrigation_used', 'weather_condition', 'days_to_harvest',
              'yield_tons_per_hectare'
              )

# split the data into training and testing sets
# set seed for reproducibility
# load libraries
set.seed(123)
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)

# prepare the data set
model_data <- processed_data %>%  select(all_of(features), fertilizer_used)

# data splitting
train_index <- createDataPartition(model_data$fertilizer_used, p = 0.7, 
                                   list = FALSE)
train_data <- model_data[train_index, ]
test_data <- model_data[-train_index,]

# train decision tree model
tree_model <- rpart(fertilizer_used ~ .,
                    data = train_data,
                    method = "class",
                    control = rpart.control(cp = 0.01, maxdepth = 5)
                    )

# visualize decision tree plot
png("decision_tree_plot.png", width = 900, height = 700)
rpart.plot(tree_model, main = "Decision Tree model for Fertilizer Application")
dev.off()

# model evaluation
# prediction
predicition <- predict(tree_model, test_data, type = 'class')

# confusion_matrix
conf_matrix <- confusionMatrix(predicition, test_data$fertilizer_used)
print(conf_matrix)

# accuracy 
print(paste("Accuracy: ", round(conf_matrix$overall['Accuracy'] * 100, 2), '%'))

# features of importance
importance <- tree_model$variable.importance
importance_df <- data.frame(feature = names(importance), importance = importance)
importance_df <- importance_df[order(-importance_df$importance),]
print(importance_df)
