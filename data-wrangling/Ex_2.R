# This is Data Wrangling Exercise 2: Dealing with Missing Values
library(tidyverse)
# Get data
titanic <- read.csv("titanic_original.csv",
                    na.strings=c("","NA"),
                    stringsAsFactors = FALSE)

glimpse(titanic)
str(titanic)

# Replace missing port of embarcation values with Southampton
table(titanic$embarked)
#notice that there are 3 missing values
titanic$embarked[is.na(titanic$embarked)] <- "S"


# Replace missing age values with mean of age column
plot(density(titanic$age,na.rm=T))
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)

# Another way to populate missing age values would be to
# take the mean of the age of passengers by title "Mr.", "Mrs.", "Master", "Miss"
# and use those means to fill in missing age values more precisely.

# Fill empty boat values with "none"

titanic$boat[is.na(titanic$boat)] <- "none"

# A missing value for cabin likely means that the passenger rode in steerage.
# It does not make sense to fill in missing cabin values.

# Create column with 1 or 0 for has_cabin_number
titanic$dummy_cabin_number <- ifelse(is.na(titanic$cabin),"0","1")

titanic$AgeGroup <- ifelse(titanic$age>50,"Old","Young")

write.csv(titanic,"titanic_clean.csv")

titanic2 <- titanic


