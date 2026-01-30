# import data 
data <- read.csv('./00_raw_data/bank-full.csv', sep = ';')

# data preprocessing
# clean column names
library(janitor)
data <- data %>% clean_names()

# check for duplicates
sum(duplicated(data))

# check for NA's
colnames(data)[apply(data, 2, anyNA)]

# check data structure
str(data)

# Descriptive Statistics Exploratory Data Analysis
summary(data$age)

# Graphical Method in Exploratory Data Analysis
library(ggplot2)
library(dplyr)

# using bar chart to visualize the job attribute
# Count occurrences of each job
job_counts <- data %>% count(job)
job_counts %>%
  ggplot(aes(x = job, y = n, fill = job)) + 
  geom_bar(stat = "identity") + 
  geom_text(aes(label = sprintf("%s", format(n, big.mark = ','))),
            vjust = -0.5, size = 3.5) +
  labs(title = "Bar plot of client jobs", x = "Job Categories", y = "Count")


# using box plot to visualize age and marital attribute
# convert marital to a factor
data[, 'marital'] <- as.factor(data[, 'marital'])
data %>% ggplot(aes(x = marital, y = age, fill = marital)) +
  geom_boxplot() +
  labs(title = "Box plot of age by marital status", x = 'marital status', 
       y = 'age')


# Box plot of age by education
data[,'education'] <- as.factor(data[,'education'])
data %>% ggplot(aes(x = education, y = age, fill = education)) + 
  geom_boxplot() + 
  labs(title = 'Box plot of age by education')

# Box plot of age by job
data[,'job'] <- as.factor(data[,'job'])
data %>% ggplot(aes(x = job, y = age, fill = job)) +
  geom_boxplot() +
  labs(title = 'Box plot of age by job category')

