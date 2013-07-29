
results <- function(N, alpha, byx, bOLS, R2xz, varx, vary, epower) {
    
    threschi <- qchisq(1 - alpha, 1) # threshold chi(1) scale
    f.value <- 1 + N * R2xz / (1 - R2xz)
    con <- (bOLS - byx) * varx # covariance due to YX confounding
    vey <- vary - byx * varx * (2 * bOLS - byx)
    
    if (vey < 0) {
    
        data.frame(Error = "Error: Invalid input. The provided parameters result in a negative estimate for variance of the error term in the two-stage least squares model.")
    
    } else {

        if (is.na(epower)) {
        
            b2sls <- byx + con / (N * R2xz)
            v2sls <- vey / (N * R2xz * varx)
            NCP <- b2sls^2 / v2sls
            # 2-sided test
            power <- 1 - pchisq(threschi, 1, NCP)
            data.frame(Parameter = c("Power", "NCP", "F-statistic"), Value = c(power, NCP, f.value), Description = c("", "Non-Centrality-Parameter", "The strength of the instrument"))    
        
        } else {
        
            # Calculation of sample size given power
            z1 <- qnorm(1 - alpha / 2)
            z2 <- qnorm(epower)
            Z  <- (z1 + z2)^2
            # Solve quadratic equation in N
            a <- (byx * R2xz)^2
            b <- R2xz * (2 * byx * con - Z * vey / varx)
            c <- con^2
            N1 <- ceiling((-b + sqrt(b^2 - 4 * a * c)) / (2 * a))
            data.frame(Parameter = "Sample Size", Value = N1)
        
        }
    }
}

results_beta_based <- function(N, alpha, R2xz, varx, vary, byx) {

    threschi <- qchisq(1 - alpha, 1)
    R2yz <- byx^2 * (varx / vary) * R2xz
    NCP <- N * R2yz / (1 - R2yz)
    power <- 1 - pchisq(threschi, 1, NCP)
    data.frame(Parameter = c("Power", "NCP"), Value = c(power, NCP), Description = c("", "Non-Centrality-Parameter"))

}