chi_square <- function(x, y) {
  chisq.test(x, y)$statistic
}
