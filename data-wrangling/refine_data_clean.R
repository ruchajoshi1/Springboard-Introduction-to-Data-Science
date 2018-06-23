# Read refine_original.csv file.
refine <- read.csv("F:\\springboard\\wrangling problem\\refine_original.csv")

#understand structure, dimensions and column names of a data frame
str(refine)
dim(refine)
names(refine)

# clean 1st column
# lower case all the letters
refine$company <- tolower(refine$company)

#check all the patterns in philips and replace with 'philips'
company_philips <- grep("^(ph|f)i*", refine$company)
refine$company[company_philips] <- "philips"

#check all the patterns in akzo and replace with 'akzo'
company_akzo <- grep("^ak*", refine$company)
refine$company[company_akzo] <- "akzo"

#check all the patterns in van houten and replace with 'van houten'
company_van <- grep("^van*", refine$company)
refine$company[company_van] <- "van houten"

#check all the patterns in unilever and replace with 'unilever'
company_unilever <- grep("^un*", refine$company)
refine$company[company_unilever] <- "unilever" 

#load tidyr
library(tidyr)

#Separate product and code number
refine <- separate(refine, col = Product.code...number, into = c("product_code", "product_number"), sep = "-")

#add a product category as a new column by checking product_code;  p=Smartphone, v=tv, x=Laptop, q=Tablet for each record
product_category <- ifelse(refine$product_code == "p", "phone", ifelse(refine$product_code == "v", "tv", ifelse(refine$product_code == "x", "Laptop", ifelse(refine$product_code == "q", "Tablet", "none"))))

refine <- cbind.data.frame(refine,product_category)

# add new column for full address by concatenating address, city and country separated by comma
refine <- unite(refine, full_address, address:country, sep = ",", remove = FALSE)

#Create dummy binary variables for company name and product category with the prefix company_ and product_ i.e.,
#Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever.
#Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet.
company_philips <- ifelse(refine$company == "philips", 1, 0)
company_akzo <- ifelse(refine$company == "akzo", 1, 0)
company_van_houten <- ifelse(refine$company == "van houten", 1, 0)
company_unilever <- ifelse(refine$company == "unilever", 1, 0)

refine <- cbind.data.frame(refine, company_philips, company_akzo, company_van_houten, company_unilever)

product_smartphone <- ifelse(refine$product_code == "p", 1, 0)
product_tv <- ifelse(refine$product_code == "v", 1, 0)
product_laptop <- ifelse(refine$product_code == "x", 1, 0)
product_tablet <- ifelse(refine$product_code == "q", 1, 0)

refine <- cbind.data.frame(refine, product_smartphone, product_tv, product_laptop, product_tablet)

# Load clean data into refine_clean.csv
write.csv(refine, file = "refine_clean.csv", row.names = FALSE)

