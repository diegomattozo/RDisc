QuantileCategorizer <- R6Class("QuantileCategorizer",
  inherit = UnsupervisedCategorizer,
  public = list(
    #' @field min_obs Minimum number of observations per category.
    min_obs = NULL,
    #' @field cutpoints Vector of cutpoints.
    cutpoints = NULL,
    initialize = function(min_obs = 30) {
      self$min_obs <- min_obs
    },
    #' @description
    #' Fit the categorizer.
    #' @param x Covariate.
    fit = function(x, ...) {
      self$cutpoints <- private$get_cutpoints(x)
      invisible(self)
    },
    #' @description
    #' Apply the categorization.
    #' @param x Covariate.
    #' @return A categorized vector.
    transform = function(x) {
      assert(length(self$cutpoints) > 0)
      x_new <- private$apply_cutpoints(x)
      x_new
    }
  ),
  private = list(
    get_cutpoints = function(x) {
      x_len <- length(x)
      stopifnot(x_len > self$min_obs)
      #  Limiting the number of percentiles to 200
      if (x_len > self$min_obs * 200) {
        self$min_obs <- floor(0.005 * x_len)
      }
      num_buckets <- x_len %/% self$min_obs
      bucket_seq <- seq(0, 1, by = (100/num_buckets)/100)
      bucket_seq[length(bucket_seq)] <- 1
      cutpoints <- quantile(x, bucket_seq)
      unique(cutpoints[order(cutpoints)])
    },

    apply_cutpoints = function(x) {
      cuts <- self$cutpoints
      cuts[1] <- -Inf
      cuts[length(cuts)] <- Inf
      new_x <- findInterval(x, cuts, rightmost.closed = T)
      new_x
    }
  )
)
