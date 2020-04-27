library(R6)
library(checkmate)
source("R/Categorizer.R")
source("R/QuantileCategorizer.R")
source("R/Categorization.R")

data(iris)
categ <- Categorization$new()
categ$min_obs
x <- iris$Petal.Length

categ$fit(x)
x_disc <- categ$transform(x)
x_disc
