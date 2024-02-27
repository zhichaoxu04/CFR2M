#' TrueR2Cal.R
#'
#' Calculate the true value of R2-based total mediation effect.
#'
#' @param alpha The coefficients between the exposure and mediators.
#' @param beta The coefficients between mediators and the outcome.
#' @param r The direct effect.
#' @param p0 The number of the true mediators
#' @param p1 The number of the type I non-mediators.
#' @param p2 The number of the type II non-mediators.
#' @param p3 The number of the noise variables.
#' @param CorM The correlation indicator (1=independent, 3=correlated).
#' @param corMat The correlation matrix of putative mediators (default=NULL).
#' @param LargeSam If TRUE, then use large sample to find the true values.
#'
#' @return A list with the elements:
#' \item{R2.true}{True value of the R2 total mediation effect}
#' \item{SOS.true}{True value of the Shared Over Simple effect (SOS)}
#' \item{R2YX.true}{True value of the R2 between X and Y}
#' \item{R2YM.true}{True value of the R2 between M and Y}
#' \item{R2YMX.true}{True value of the R2 between Y and XM}
#'
#' @importFrom MASS mvrnorm
#' @importFrom stats rnorm
#' @importFrom stats lm
#' @importFrom stats var
#'
#' @export
#' @examples
#' p0 <- 20
#' p1 <- 20
#' p2 <- 20
#' p3 <- 40
#' alpha <- c(rnorm(p0, mean = 0, sd = 1.5), rep(0, p1), 
#' rnorm(p2, mean = 0, sd = 1.5), rep(0, p3))
#' beta <- c(rnorm(p0, mean=0, sd=1.5),
#' rnorm(p1, mean=0, sd=1.5), rep(0, p2+p3))
#' r <- 1
#' CorM <- 3
#' TrueR2Cal(alpha,beta,r=3,p0,p1,p2,p3,CorM,LargeSam=F)
#' TrueR2Cal(alpha,beta,r=3,p0,p1,p2,p3,CorM,LargeSam=T)
TrueR2Cal <- function(alpha,beta,r=3,p0,p1,p2,p3,CorM,corMat=NULL,LargeSam=TRUE){
  
  if(!CorM %in% c(1,2,3)){
    stop("Correlation structure indicator error.")
  }
  
  if(sum(p0, p1, p2, p3) <= 0){
    stop("Number of mediators error.")
  }else{
    p <- sum(p0, p1, p2, p3)
    res.sd <- 1
  }
  
  if(is.null(corMat)){
    corMat <- diag(p0+p1+p2+p3)
  }
  
  if(p0 == 0){
    # No true mediators
    R2.true <- 0
    R2YM.true <- 0
    R2YX.true <- 0
    R2YMX.true <- 0
    SOS.true <- 0
  }else if(LargeSam == TRUE){
    set.seed(1)
    N_large <- 1000000
    x_large <- stats::rnorm(N_large) # Generate the same x
    M_large <- matrix(0, nrow = N_large, ncol = p)
    
    if (CorM == 1){
      # Independent
      for (i in 1:p){M_large[, i] <- alpha[i] * x_large + stats::rnorm(N_large, 0, 1)}
    }else if(CorM == 2){
      # Correlated
      for (i in 1:500){M_large[, i] <- alpha[i] * x_large + stats::rnorm(N_large, 0, 1)}
      for (i in 501:1000){M_large[, i] <- 2*M_large[, i-500] + stats::rnorm(N_large, 0, 1)}
      for (i in 1001:p){M_large[, i] <- -M_large[, 1] + stats::rnorm(N_large, 0, 1)}
    }else if(CorM == 3){
      # Correlated
      Residual_large <- MASS::mvrnorm(N_large, mu = rep(0, p), Sigma = corMat)
      for (i in 1:p){M_large[, i] <- alpha[i] * x_large + Residual_large[, i]}
    }
    
    # Compute the outcome
    Y_large <- r * x_large + as.vector(beta %*% t(M_large)) + stats::rnorm(N_large, 0, res.sd)
    
    # Perform OLS to get the variance
    olsYXM.large <- stats::lm(Y_large ~ cbind(x_large, M_large[, 1:(p0)]))
    VYXM_large <- stats::var(olsYXM.large$residuals)
    olsYM.large <- stats::lm(Y_large ~ M_large[, 1:(p0)])
    VYM_large <- stats::var(olsYM.large$residuals)
    olsYX.large <- stats::lm(Y_large ~ x_large)
    VYX_large <- stats::var(olsYX.large$residuals)
    VY_large <- stats::var(Y_large)
    
    # Compute the True value of each part
    R2.true <- 1 - (VYX_large + VYM_large - VYXM_large)/VY_large
    R2YM.true <- 1 - VYM_large/VY_large
    R2YX.true <- 1 - VYX_large/VY_large
    R2YMX.true <- 1 - VYXM_large/VY_large
    SOS.true <- R2.true/R2YX.true
  }else{
    vary <- (r + sum(alpha * beta))^2 + as.numeric(beta %*% corMat %*% beta) + res.sd^2
    R2YM.true <- as.vector(((r + sum(alpha * beta))^2 - r^2/(1 + as.numeric(alpha[1:p0] %*% solve(corMat[1:p0, 1:p0]) %*% alpha[1:p0]))
                              + as.numeric(beta[1:p0] %*% corMat[1:p0, 1:p0] %*% beta[1:p0]) )/ vary)
    R2YX.true <- as.vector((r + sum(alpha * beta))^2 / vary)
    R2YMX.true <- as.vector(((r + sum(alpha * beta))^2 + as.numeric(beta[1:p0] %*% corMat[1:p0, 1:p0] %*% beta[1:p0]) ) / vary)
    R2.true <- R2YM.true + R2YX.true - R2YMX.true
    SOS.true <- R2.true/R2YX.true
  }
  
  return(list(R2.true=R2.true, SOS.true=SOS.true, R2YX.true=R2YX.true, 
              R2YM.true=R2YM.true, R2YMX.true=R2YMX.true))
}










