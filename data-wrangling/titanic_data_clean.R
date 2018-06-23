#Read titanic_original.csv file
titanic_df <- read.csv("F:\\springboard\\wrangling problem\\titanic_original.csv")

# find more details about the data set
str(titanic_df)
dim(titanic_df)
names(titanic_df)

# look for NA 
any(is.na(titanic_df))

#check summary for NAs
summary(titanic_df)

#Find missing values from embarkation column and replace them with S.
titanic_df$embarked[titanic_df$embarked == ""] <- "S" 

#Fill the missing values in age column by finding mean of age column and use it for missing places
#age_val <- is.finite(titanic_df$age)

m <- mean(titanic_df$age[!is.na(titanic_df$age)])
titanic_df$age[is.na(titanic_df$age)] <- m

#This is also correct 
#mean(na.omit(titanic_df$age))

#Fill the missing values in the lifeboat column with NA. 
boat <- as.character(titanic_df$boat)
boat[boat == ""] <- NA
titanic_df$boat <- boat

#Fill the missing values in the cabin number and create a new column has_cabin_number with 1 and 0 values.
has_cabin_number <- ifelse((titanic_df$cabin == ""),0,1)

titanic_df <- cbind.data.frame(titanic_df, has_cabin_number)

# write cleaned dataset into titanic_clean.csv 
write.csv(titanic_df, file = "titanic_clean.csv", row.names = FALSE, quote = FALSE)
