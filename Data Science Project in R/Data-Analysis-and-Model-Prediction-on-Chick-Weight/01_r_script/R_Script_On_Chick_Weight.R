# DATA ANALYSIS ON CHICKWEIGHT
# load the data
data()

df <- data.frame(ChickWeight)
View(df)

# load the package janitor to clean names 
# load dplyr
library(dplyr)
library(janitor)
df <-df %>%  clean_names()

# check the structure of the data
str(df)
# a glimpse at the structure indicates our data has been one hot encoded

# to check for NA's
colnames(df)[apply(df, 2, anyNA)]

# data visualization
# summary of the weight
summary(df$weight)
# From the summary, the minimum and maximun weight is 35 and 373 respectively.
# 1st Quartile: 25% of the data is below 63 or 75% of the data is above 63.
# 3rd Quartile: 25% of the data is above 163.8 or 75% of the data is below 163.8
# Skewness: the mean(121.8) is higher than the median (103.0), suggests that
# the data is positively skewed and thus it is skewed to the right.

# load the package ggplot2
library(ggplot2)

# using bar plot to visualize the diet
bar_plot <- df %>% arrange(desc(diet)) %>% 
  ggplot(aes(x = diet, fill = diet,)) + geom_bar() + labs(title="A bar plot of chicken diet", 
                                                          caption = "Data Source: R dataset")
print(bar_plot)

# This bar plot shows the distribution of different diet types in the data set
# From the distribution diet 1 overwhelmingly happens to be the most consumed diet
# Diet 2, 3, 4 have a moderate count
# Looking at the visual representation, each diet is represented by a different color bar

# using box plot to visualize the weight of the chicks and the diet
box_plot <- ggplot(df, aes(x= diet, y = weight,  fill = diet)) +
  geom_boxplot() + labs(title="Box plot of weight by diet", caption = "Data Source: R dataset")
print(box_plot)

# Analysis
# This box plot compares the weight of the chicks across different diet types.
# The Y axis represents the weight of the chicks 
# The X axis represents the type of diets
# Each box represents the interquartile range for that diet type
# From the visualization, diet 4 has the highest median weight followed closely by diet 3
# Diet 1 and 2 have lower median weight
# Diet 1 and 2 both have outliers, indicating some very high weights amongthe chicks
# Diet 1 shows the narrowest weight range, indicating less variability


# MACHINE LEARNING

# load the required libraries
library(rpart.plot)
library(rpart)

# split the data into training and testing
set.seed(2024) # for reproducibility
train_index <- sample(1:nrow(df), size = (0.7 * nrow(df)), replace = FALSE)
train_data <- df[train_index,]
test_data <- df[-train_index,]

# build model using decision tree
tree_model <- rpart(diet ~., data = train_data)
print(tree_model)
rpart.plot(tree_model)

# predict on the test
predictions <- predict(tree_model, test_data, type = "class")
predictions

# Evaluate the model using confusion matrix
confusion_matrix <- table(Actual = test_data$diet, Predicted = predictions)
print(confusion_matrix)

# Calculate the accuracy of the model
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", round(accuracy*100,2), "%"))


# To know which features influenced the most in the model
importance <- tree_model$variable.importance
importance_df <- data.frame(feature = names(importance), importance = importance)
importance_df <- importance_df[order(-importance_df$importance),]
print(importance_df)

write.csv(df, file = "dataset on chicks.csv", row.names = FALSE)
