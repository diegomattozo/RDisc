#' R6 Base class for defining categorizers.
Categorizer <- R6Class("Categorizer",
  public = list(
   initialize = function() {
     stop("This class should not be instantiated.")
   },
   #' @description
   #' Abstract method for fitting a categorizer.
   #' @param x One dimensional covariate.
   #' @param y One dimensional response variable (optional).
   fit = function(x, y = NULL) {
     stop("You must implement this method.")
   },
   #' @description
   #' Abstract method for transforming a new covariate with the cutpoint found
   #' fitting the categorizer.
   #' @param x One dimensional covariate to transform.
   transform = function(x) {
     stop("You must implement this method.")
   }
  )
)
#' R6 Base class for defining unsupervised categorizers.
#' @export
UnsupervisedCategorizer <- R6Class("UnsupervisedCategorizer",
  inherit = Categorizer)

#' R6 Base class for defining supervised categorizers.
#' @export
SupervisedCategorizer <- R6Class("SupervisedCategorizer",
  inherit = Categorizer,
  public = list(
    metric_ = NULL
  ),
  active = list(
    #' @description
    #' A setter/getter to define the metric to be maximized.
    #' @param metric Must be a function that accepts a covariate, a response
    #' variable and a vector of cutpoints to be applied to the explanatory variable
    #' an returns a value.
    #' @examples
    #' categorizer <- SupervisedCategorizer$new()
    #' categorizer$metric <- function(x, y, cutpoints) {
    #'   x_new <- findInterval(x, cutpoints, rightmost.closed = T)
    #'   chisq.test(x_new, y)$statistic
    #' }
    metric = function(metric) {
      stop("You must implement the metric getter/setter.")
    }
  )
)
