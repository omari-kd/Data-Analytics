
# import data 
data <- read.csv("./00_raw_data/bank.csv", sep = ";")

# data cleaning
library(janitor)
data <- data %>% clean_names()

# check for duplicates
sum(duplicated(data))

# check for NA's
colnames(data)[apply(data, 2, anyNA)]

# check data structure
str(data)


# Data modelling 
# Preprocess the data

# Encode target variable
data[,'y'] <- as.factor(data[,'y'])

# check the levels of the target variable
levels(data$y)

# assign numeric levels to each
data$subscription <- as.numeric(factor(data$y, levels = levels(data$y)))

# feature engineering
preprocess_data <- function(data){
  # converting variables to numeric
  data$job <- as.numeric(factor(data$job))
  data$marital <- as.numeric(factor(data$marital))
  data$education <- as.numeric(factor(data$education))
  data$default <- ifelse(data$default == "yes", 1, 0)
  data$housing <- ifelse(data$housing == "yes", 1, 0)
  data$loan <- ifelse(data$loan == "yes", 1, 0)
  data$contact <- as.numeric(factor(data$contact))
  data$month <- as.numeric(factor(data$month))
  data$poutcome <- as.numeric(factor(data$poutcome))
  
  return(data)
}

# prepare data for modeling
processed_data <- preprocess_data(data)
View(processed_data)

# select the features
features <- c("age", "job", "marital", "education", "default", "balance", 
              "housing", "loan", "contact", "day", "month", "duration", 
              "campaign", "pdays", "previous", "poutcome")

# split the data into training and testing sets
# set seed for reproducibility
# load libraries
set.seed(123)
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)

# Prepare the data set
model_data <- processed_data %>% select(all_of(features), y)

# split data 
train_index <- createDataPartition(model_data$y, p = 0.7, list = FALSE)
train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

# Train Decision Tree Model
tree_model <- rpart(
  y ~ ., 
  data = train_data, 
  method = "class",
  control = rpart.control(cp = 0.01, maxdepth = 5)
)

# Visualize the decision tree
png("decision_tree_plot.png", width = 800, height = 600)
rpart.plot(tree_model, main = "Decision Tree for Bank Subscription")
dev.off()

# Model Evaluation
# Predictions
predictions <- predict(tree_model, test_data, type = "class")

# Confusion Matrix
conf_matrix <- confusionMatrix(predictions, test_data$y)
print(conf_matrix)

# Calculate accuracy
print(paste("Accuracy:", round(conf_matrix$overall['Accuracy']*100, 2), "%"))

# calculate Precision
precision <- conf_matrix$byClass['Pos Pred Value']
print(paste("Precision:", round(precision*100, 2), "%"))

# calculate recall
recall <- conf_matrix$byClass['Sensitivity']
print(paste("Recall:", round(recall*100, 2), "%"))

# calculate f1score
f1_score <- 2 * (precision * recall) / (precision + recall)
print(paste("F1 Score:", round(f1_score, 4)))

# features that are influential to the model
importance <- tree_model$variable.importance
importance_df <- data.frame(feature = names(importance), importance = importance)
importance_df <- importance_df[order(-importance_df$importance),]
print(importance_df)