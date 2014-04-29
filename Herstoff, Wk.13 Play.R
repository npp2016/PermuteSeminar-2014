## Playing with data from snails to see what I'm doing for Thursday...
## Largely pirated code from:
##    http://www.statmethods.net/stats/regression.html

library(MASS)
## Use the preprogrammed snail data
head(snails)
##  Species Exposure Rel.Hum Temp Deaths  N

# Multiple Linear Regression Example
fit.1 <- lm(Deaths~Species + Exposure+ Rel.Hum+ Temp+N,data=snails)
  summary(fit.1) # show results

# Other useful functions
coefficients(fit.1) # model coefficients
confint(fit.1, level=0.95) # CIs for model parameters
fitted(fit.1) # predicted values
residuals(fit.1) # residuals
anova(fit.1) # anova table
vcov(fit.1) # covariance matrix for model parameters
influence(fit.1) # regression diagnostics 

# diagnostic plots
layout(matrix(c(1,2,3,4),2,2)) # setting 4 graphs/page
plot(fit.1)

## COmpare model fits.
## Same as above:
##      fit.1 <- lm(Deaths~Species + Exposure+ Rel.Hum+ Temp+N,data=snails)
fit.2 <- lm(Deaths~Exposure+ Rel.Hum+ Temp,data=snails)
  anova(fit.1, fit.2)


## Stepwise Regression and variable selection
  step <- stepAIC(fit.1, direction="both")
  step$anova # display results 

# Calculate Relative Importance for Each Predictor: NOT WORKING YET.
library(relaimpo)
??calc.relimp ## Function to calculate relative importance metrics for linear models
data(snails)
calc.relimp<- calc.relimp(snails, type=c("Species", "Exposure", "Rel.Hum", "Temp", "Deaths", "N"), rela=TRUE)

# Bootstrap Measures of Relative Importance (1000 samples): NOT WORKING YET.
boot <- boot.relimp(fit, b = 1000, type = c("lmg","last", "first", "pratt"), rank = TRUE, diff = TRUE, rela = TRUE)
booteval.relimp(boot) # print result
plot(booteval.relimp(boot,sort=TRUE)) # plot result 