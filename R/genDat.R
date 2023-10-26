#' genDat.R
#'
#' Calculate the test statistic and p-value for interval-censored competing risks SKAT.
#'
#' @param leftDmat n*(p+nknots+2) design matrix for left end of
#' @param rightDmat n*(p+nknots+2) design matrix for right end of interval.
#' @param leftTimes n*1 vector of left side of interval times.
#' @param deltaVec n*1 vector of the event cause (cause 1 or 2; or right-censored 0).
#' @param gMat n*q genotype matrix.
#' @param gSummed n*1 vector of summed genotype matrix.
#' @param null_beta (p+nknots+2)*1 vector of coefficients for null model.
#' @param pvalue If TRUE, then find the p-value
#'
#' @return A list with the elements:
#' \item{p_SKAT}{ICSKAT p-value}
#' \item{p_burden}{IC burden test p-value}
#' \item{complex}{Indicator of whether the SKAT variance matrix was positive definite}
#' \item{sig_mat}{The covariance matrix of the score equations for genetic effects when treated as fixed effects}
#' \item{skatQ}{SKAT test statistic}
#' \item{burdenQ}{Burden test statistic}
#' \item{Ugamma}{Score vector}
#' \item{lambdaQ}{Vector of eigenvalues of variance matrix}
#' \item{null_beta}{The fitted null parameters}
#' \item{err}{Will be 0 for no error, 22 if had to adjust parameters on CompQuadForm (totally normal), or 99 if NA in variance matrix. ICSKATwrapper will return 1 here if the null fit has an error}
#' \item{errMsg}{Explains error code, blank string if no error}
#'
#' @importFrom CompQuadForm davies
#' @importFrom stats pchisq
#'
#' @export
#' @examples
#' n <- 30000
#' q <- 500
genDat <- function() {
  print("Hello, world!!")
}


