#' @title Simulated data for tutorial
#'
#' @description simulated 4 independent studies for meta-analysis
#'
#' @format A list of 4 studies with different sample sizes and each of them contains:
#' \describe{
#'   \item{X}{The exposure mimics age}
#'   \item{Y}{The outcome mimics systolic blood pressure}
#'   \item{M}{The mediators}
#' }
#' @references <https://www.biorxiv.org/content/10.1101/2023.02.06.527391v1.abstract>
"data"
# 
# N <- 1000
# Outcome <- stats::rnorm(N, 100, sd = 15)
# Exposure <- stats::rnorm(N, 60, sd = 10)
# M <- matrix(0, nrow = N, ncol = 50)
# M <- scale(apply(M, 2, function(x) rnorm(N, 0, 1) * Exposure * 0.1 + rnorm(N, 0, 1)))
# colnames(M) <- paste0("M", 1:50)
# data <- cbind(data.frame(Y = Outcome, X = Exposure), M)
# save(data, file = "/Users/xu/Desktop/CFR2M/data/data.rda")
# usethis::use_data(data, overwrite = TRUE)
