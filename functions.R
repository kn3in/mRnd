
results <- function(N, alpha, byx, bOLS, R2xz, varx, vary, epower) {
    threschi <- qchisq(1 - alpha, 1) # threshold chi(1) scale
    FF <- 1 + N * R2xz / (1 - R2xz)
    con <- (bOLS - byx) * varx # covariance due to YX confounding
    b2sls <- byx + con / (N * R2xz)
    vey <- vary - byx * varx * (2 * bOLS - byx)
    v2sls <- vey / (N * R2xz * varx)

    R2xz_unadj <- R2xz + 1 / N

    NCP <- b2sls^2 / v2sls
    # 2-sided test
    power <- 1 - pchisq(threschi, 1, NCP)

    # Calculation of sample size given power
    z1 <- qnorm(1 - alpha / 2)
    z2 <- qnorm(epower)
    Z  <- (z1 + z2)^2
    # Solve quadratic equation in N
    a <- (byx * R2xz)^2
    b <- R2xz * (2 * byx * con - Z * vey / varx)
    c <- con^2
    N1 <- (-b + sqrt(b^2 - 4 * a * c)) / (2 * a)

    data.frame( Parameter = c("alpha", "threschi", "byx", "bOLS", "b2sls", "v2sls", "R2xz", "FF", "R2xz_unadj", "power", "N1"),
                Value     = c(alpha, threschi, byx, bOLS, b2sls, v2sls, R2xz, FF, R2xz_unadj, power, N1))
}

annotate <- function(dt) {
    my_annot <- data.frame(Parameter = c("alpha", "threschi", "byx", "bOLS", "b2sls", "v2sls", "R2xz", "FF", "R2xz_unadj", "power", "N1"),
                           Description = c("\\(\\alpha\\)", "threschi", "\\(\\beta_{yx}\\)", "\\(\\beta_{OLS}\\)", "\\(\\beta_{2SLS}\\)", "\\(Var(2SLS)\\)", "\\(R^2_{xz}\\)", "FF", "\\(R^2_{xz unadj}\\)", "power", "\\(N1\\)"))  

    merge(dt, my_annot, by.x = "Parameter", by.y = "Parameter", all.x = TRUE)
}