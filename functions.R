
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

results_beta_based <- function(N, alpha, R2xz, varx, vary, byx, epower) {

    threschi <- qchisq(1 - alpha, 1)
    R2yz <- byx^2 * (varx / vary) * R2xz
    
    if(is.na(epower)) {
    
        NCP <- N * R2yz / (1 - R2yz)
        power <- 1 - pchisq(threschi, 1, NCP)
        data.frame(Parameter = c("Power", "NCP"), Value = c(power, NCP), Description = c("", "Non-Centrality-Parameter"))
    
    } else {

        z1 <- qnorm(1 - alpha / 2)
        z2 <- qnorm(epower)
        Z  <- (z1 + z2)^2
        N2 <- Z * (1 - R2yz) / R2yz
        data.frame(Parameter = "Sample Size", Value = N2)

    }
}


results_binary <- function(N, alpha, R2xz, K, OR, epower) {
    if (is.na(epower)) {
        power <- pnorm(sqrt(N*R2xz*K*(1-K))*abs(log(OR))-qnorm(1-alpha/2))
        data.frame(Parameter = "Power", Value = power)    
    } else {
        # Calculation of sample size given power
        N1 <- ( qnorm(1-alpha/2) + qnorm(epower) )^2 / log(OR)^2/R2xz/K/(1-K)
        N1 <- ceiling(N1)
        data.frame(Parameter = "Sample Size", Value = N1)
    }
}

parse_git <- function() {   
    commit <- system("git log -1 --pretty=format:'%h - (%ci)' --abbrev-commit",  intern = TRUE)
    tag    <- system("git describe --exact-match --abbrev=0 --tags",  intern = TRUE, ignore.stderr = FALSE)
    list(tag = tag, commit = commit)
}

wrap_list_in_paragraphs <- function(a_list) lapply(a_list, p)

pretty_git <- function() wrap_list_in_paragraphs(parse_git())

push_name_into_paragraph <- function(name_of_item, a_list) p(paste(name_of_item, ": "), a_list[[name_of_item]])

wrap_with_names <- function(a_list) lapply(names(a_list), function(x) push_name_into_paragraph(x, a_list))

pretty_git2 <- function() wrap_with_names(parse_git())








