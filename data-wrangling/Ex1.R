# This is Data Wrangling Exercise 1: Basic Data Manipulation
library("tidyverse")
# get data
refine_original <- read.csv("refine_original.csv",stringsAsFactors = FALSE)
refine_draft <- refine_original



# correct spellings
refine_draft$company[agrep("philips", refine_draft$company, ignore.case = TRUE, value = FALSE, max.distance = 3)] <- "philips"
refine_draft$company[agrep("van houten", refine_draft$company, ignore.case = TRUE, value = FALSE, max.distance = 3)] <- "van houten"
refine_draft$company[agrep("akzo", refine_draft$company, ignore.case = TRUE, value = FALSE, max.distance = 1)] <- "akzo"
refine_draft$company[agrep("unilever", refine_draft$company, ignore.case = TRUE, value = FALSE, max.distance = 3)] <- "unilever"

#Method 2

#Correct spelling errors in company name and make them lower case
# prodPurchases$company <- tolower(prodPurchases$company)
# prodPurchases$company <- sub(pattern = ".*\\ps$", replacement = "Philips", x = prodPurchases$company)
# prodPurchases$company <- sub(pattern = "^ak.*", replacement = "Akzo", x = prodPurchases$company)
# prodPurchases$company <- sub(pattern = "^u.*", replacement = "Unilever", x = prodPurchases$company)
# prodPurchases$company <- sub(pattern = "^v.*", replacement = "Van Houten", x = prodPurchases$company)

# separate product code and number
refine_draft <- separate(data=refine_draft, 
                         col='Product.code...number', 
                         into=c('product_code', 'product_number'), 
                         sep = "-",
                         remove=TRUE)

# add product category column
refine_draft <- mutate(refine_draft, 'product_category' = product_code)
  

refine_draft$product_category <- gsub("p", "Smartphone", refine_draft$product_category)
refine_draft$product_category <- gsub("v", "TV", refine_draft$product_category)
refine_draft$product_category <- gsub("x", "Laptop", refine_draft$product_category)
refine_draft$product_category <- gsub("q", "Tablet", refine_draft$product_category)

# add full address
refine_draft <- unite(refine_draft, "full_address", address, city, country, sep = ", ")

# create dummy variables for company category
dummy_philips <- as.numeric(refine_draft$company == "philips")
dummy_akzo <- as.numeric(refine_draft$company == "akzo")
dummy_van_houten <- as.numeric(refine_draft$company == "van houten")
dummy_unilever <- as.numeric(refine_draft$company == "unilever")

refine_draft <- cbind(refine_draft, dummy_philips, dummy_akzo, dummy_van_houten, dummy_unilever)

refine_clean <- refine_draft
write_csv(refine_clean, "Yash.csv")
