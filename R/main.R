library(R6)
library(checkmate)
source("R/metrics.R")
source("R/Categorizer.R")
source("R/QuantileCategorizer.R")
source("R/Categorization.R")
source("R/ULVCategorizer.R")

data(iris)
x <- iris$Petal.Length
y <- iris$Species

ulv_categ <- ULVCategorizer$new()
ulv_categ$fit(x = x, y = y)
