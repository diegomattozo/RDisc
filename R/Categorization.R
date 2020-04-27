#' R6 Categorization Class
#' @export
Categorization <- R6Class("Categorization",
  public = list(
    #' @field Reference to a categorizer.
    categ = QuantileCategorizer$new(min_obs = 30),
    #' @description
    #' Set a new Categorizer. A categorizer in this case is a instance of a R6 class following
    #' the predefined interface in [UnsupervisedCategorizer()] and [SupervisedCategorizer()].
    #' @param categorizer Instance of a categorizer.
    set_categorizer = function(categorizer) {
      self$categ <- categorizer
    },
    #' @description
    #' Fit the categorizer.
    #' @param x A covariate to categorize.
    #' @param y A response variable if the categorizer is supervised.
    fit = function(x, y = NULL) {
      self$categ$fit(x, y)
      invisible(self)
    },
    #' @description
    #' Categorize a vector.
    #' @param x Variable to apply the categorizer.
    #' @return A categorized vector.
    transform = function(x) {
      x_new <- self$categ$transform(x)
      x_new
    },
    #' @description
    #' Apply fit and transform.
    #' @param x Variable to fit and transform.
    #' @return A categorized vector.
    fit_transform = function(x) {
      self$categ$fit(x)
      x_new <- self$categ$transform(x)
      x_new
    }
  )
)
