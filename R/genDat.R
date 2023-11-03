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
#' @importFrom stats rnorm
#'
#' @export
#' @examples
#' p0 <- 20
#' p1 <- 20
#' p2 <- 20
#' p3 <- 40
#' N <- 1000
#' alpha <- c(rnorm(p0, mean = 0, sd = 1.5), rep(0, p1), 
#' rnorm(p2, mean = 0, sd = 1.5), rep(0, p3))
#' beta <- c(rnorm(p0, mean=0, sd=1.5),
#' rnorm(p1, mean=0, sd=1.5), rep(0, p2+p3))
#' r <- 1
#' CorM <- 3
#' genDat(alpha,beta,r=3,p0,p1,p2,p3,CorM,LargeSam=F)
genDat <- function(alpha,beta,r=3,res.sd=1,N,p0,p1,p2,p3,CorM,corMat=NULL,seed=1) {
  set.seed(seed) 
  
  if(!CorM %in% c(1,2,3)){
    stop("Correlation structure indicator error.")
  }
  
  if(sum(p0, p1, p2, p3) <= 0){
    stop("Number of mediators error.")
  }else{
    p <- sum(p0, p1, p2, p3)
  }
  
  if(is.null(corMat)){
    corMat <- diag(p0+p1+p2+p3)
  }
  
  # Generate the exposure and mediators matrix
  x <- stats::rnorm(N, 0, 1) # exposure
  M <- matrix(0, nrow=N, ncol=p) # M matrix
  
  if (CorM == 1){
    for (i in 1:p){M[, i] <- alpha[i] * x + stats::rnorm(N, 0, 1)}
  }else if(CorM == 2){
    for (i in 1:500){M[, i] <- alpha[i] * x + stats::rnorm(N, 0, 1)}
    for (i in 501:1000){M[, i] <- 2*M[, i-500] + stats::rnorm(N, 0, 1)}
    for (i in 1001:p){M[, i] <- -M[, 1] + stats::rnorm(N, 0, 1)}
  }else if(CorM == 3){
    Residual <- MASS::mvrnorm(N, mu=rep(0, p), Sigma=corMat)
    for (i in 1:p){M[, i] <- alpha[i] * x + Residual[, i]}
  }
  
  Y <- r * x + as.vector(beta %*% t(M)) + stats::rnorm(N, 0, res.sd)
  M <- scale(M, center=T, scale=T) # Standardized M
  
  # Split the data into two subsamples
  set.seed(rep)
  idx1 <- sample(1:N, ceiling(N/2), replace = FALSE) 
  tdat <- cbind(Y=Y, x=x, M=M)
  training <- tdat[idx1, ]
  testing <- tdat[-idx1, ]
  M.train <- training[, 3:ncol(training)]  # X + M
  M.test <- testing[, 3:ncol(testing)]  # X + M
  X.train <- training[, 2]
  Y.train <- training[, 1]
  X.test <- testing[ , 2]
  Y.test <- testing[ , 1] 
  
  return(list())
  
}










