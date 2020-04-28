#' Univariate Low Variance Categorizer
ULVCategorizer <- R6Class("ULVCategorizer",
  inherit = SupervisedCategorizer,
  public = list(
    #' @field min_obs Minimum number of observations per bin.
    min_obs = NULL,
    #' @field min_num_bin Mininum number of bins.
    min_num_bins = NULL,
    #' @field metric_fn A function to be maximized.
    metric_fn = NULL,
    #' @field alpha Stop criteria in each iteration: new_metric_value > alpha*old_metric_value.
    alpha = NULL,
    #' @field lambda Control the variance penalization.
    lambda = NULL,
    #' @field cutpoints Vector of cutpoints.
    cutpoints = NULL,
    initialize = function(min_obs = 30, min_num_bins = 2, alpha = 0.05, ...) {
      self$min_obs = min_obs
      self$min_num_bins = min_num_bins
      self$alpha = alpha
      self$metric_fn = chi_square
    },
    set_params = function(...) {
      params_list <- c("min_obs", "min_num_bins", "metric_fn", "alpha", "lambda")
      args <- list(...)
      for (param in params_list) {
        if (param %in% names(args)) {
          self[[param]] = args[[param]]
        }
      }
    },
    #' @description
    #' Fit the categorizer.
    #' @param x Covariate.
    #' @param y Response variable.
    fit = function(x, y) {
      private$QCateg = QuantileCategorizer$new(min_obs = self$min_obs)
      initial_cutpoints <- private$QCateg$fit(x)$cutpoints
      private$run_categorizer(x, y, initial_cutpoints)
      invisible(self)
    },
    transform = function(x) {

    }
  ),
  private = list(
    QCateg = NULL,
    run_categorizer = function(x, y, initial_cutpoints, ...) {
      n_bins <- 1
      cutp <- c(-Inf, Inf)
      n_bins <- length(cutp) - 1
      # remove min and max values
      cutp_avail <- initial_cutpoints[2:(length(initial_cutpoints)-1)]
      while(n_bins < self$min_num_bins || new_metric >= (1 + self$alpha) * old_metric) {
        old_metric <- new_metric
        result <- private$find_best_cutp(x, y, cutp_avail, ...)
        new_metric <- result$metric
        cutp <- result$cutp
        # TODO: 1) remove best_cupt from cutp_avail
        # TODO: 2) add best_cupt to cupt and sort it
        n_bins <- length(cutp) - 1
      }
    }
  )
)
