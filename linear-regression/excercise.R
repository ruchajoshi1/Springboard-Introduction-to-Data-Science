## Exercise: least squares regression
## ────────────────────────────────────────

##   Use the /states.rds/ data set. Fit a model predicting energy consumed
##   per capita (energy) from the percentage of residents living in
##   metropolitan areas (metro). Be sure to
##   1. Examine/plot the data before fitting the model
##   2. Print and interpret the model `summary'
##   3. `plot' the model to look for deviations from modeling assumptions

##   Select one or more additional predictors to add to your model and
##   repeat steps 1-3. Is this model significantly better than the model
##   with /metro/ as the only predictor?

## Interactions and factors
## ══════════════════════════

## Modeling interactions
## ─────────────────────────

##   Interactions allow us assess the extent to which the association
##   between one predictor and the outcome depends on a second predictor.
##   For example: Does the association between expense and SAT scores
##   depend on the median income in the state?

# read the states data
states.data <- readRDS("dataSets/states.rds") 
#get labels
states.info <- data.frame(attributes(states.data)[c("names", "var.labels")])
#look at last few labels
tail(states.info, 8)

# summary of energy and metro columns, all rows
sts.ex.sat1 <- subset(states.data, select = c("metro", "energy"))
summary(sts.ex.sat1)

# correlation between expense and csat
cor(sts.ex.sat1, use = "pairwise")

## Plot the data before fitting models

# scatter plot of energy vs metro
plot(sts.ex.sat1)

##   • Linear regression models can be fit with the `lm()' function

# Fit our regression model
sat.mod1 <- lm(energy ~ metro, # regression formula
              data=states.data) # data set

# Summarize and print the results
summary(sat.mod1) # show regression coefficients table

plot(sat.mod1)

#add more predictors

sts.ex.sat2 <- subset(states.data, select = c("energy", "metro", "area"))
summary(sts.ex.sat2)

# correlation between expense and csat
cor(sts.ex.sat2, use = "pairwise")

## Plot the data before fitting models

# scatter plot of energy vs metro + area
plot(sts.ex.sat2)

sat.mod2 <- lm(energy ~ area + metro, data = states.data)

summary(sat.mod2)
  

## The lm class and methods
## ────────────────────────────

##   OK, we fit our model. Now what?
##   • Examine the model object:

class(sat.mod2)
names(sat.mod2)
methods(class = class(sat.mod))

##   • Use function methods to get more information about the fit

confint(sat.mod)
# hist(residuals(sat.mod))

## Linear Regression Assumptions
## ─────────────────────────────────

##   • Ordinary least squares regression relies on several assumptions,
##     including that the residuals are normally distributed and
##     homoscedastic, the errors are independent and the relationships are
##     linear.

##   • Investigate these assumptions visually by plotting your model:

par(mar = c(4, 4, 2, 2), mfrow = c(1, 2)) #optional
plot(sat.mod, which = c(1, 2)) # "which" argument optional

## Comparing models
## ────────────────────

##   Do congressional voting patterns predict SAT scores over and above
##   expense? Fit two models and compare them:

# fit another model, adding house and senate as predictors
sat.voting.mod <-  lm(csat ~ expense + house + senate,
                      data = na.omit(states.data))
sat.mod <- update(sat.mod, data=na.omit(states.data))
# compare using the anova() function
anova(sat.mod, sat.voting.mod)
coef(summary(sat.voting.mod))
