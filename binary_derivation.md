#### Estimating Power in Mendelian Randomization: Binary Outcomes

Previous equations for estimating power using the non-centrality parameter in the case of continuous outcomes[^note-id] were adapted for binary outcomes using an approximate linear model on the observed binary (0-1) scale. The calculations below are approximations and in the absence of X-Y confounding.

Input parameters for power calculations:  
\\(K\\) = proportion of cases in the (intended) study  
\\(N\\) = total sample size  
\\(OR\\) = True odds ratio of the outcome variable per standard deviation of the exposure variable  
\\(R^2_{xz}\\) = proportion of variance in exposure variable explained by SNPs

A linear model on the 0-1 scale in the population:

\\(y_{01} = K + b_{01}x + e\\)

The probabilities of the binary outcomes (y = 0 or y =1) for x = 0 and x = 1 standard deviation above the mean are:

\\(Prob(disease | x = 0) = K\\)  
\\(Prob(control | x = 0) = 1 - K\\)  
\\(Prob(disease | x = 1) = K + b_{01}\\)  
\\(Prob(control | x = 1) = 1 - K - b_{01}\\)

The odds ratio \\(OR = \frac{\frac{K + b_{01}}{1 - K - b_{01}}}{\frac{K}{1 - K}}\\)

With input variables OR and K, the regression coefficient is derived on the observed scale:

\\(b_{01} = K(\frac{OR}{1 + K(OR - 1)} – 1)\\)

The sampling variance of the estimate of \\(b_{01}\\) is, approximately,

\\(var(\hat{b_{01}}) = var(e) = var(y_{01}) – b^2_{01}var(x) = K(1-K) – b^2_{01}\\)

So the mean and sampling variance of the MR estimator on the linear scale are:

\\(b_{MR} = K(\frac{OR}{1 + K(OR-1)} – 1)\\)

\\(var(b_{MR}) = \frac{var(e)}{N R^2_{xz}} = \frac{K(1-K) – b^2_{01}}{N R^2_{xz}}\\)

and

\\(NCP = \frac{b^2_{MR}}{var(b_{MR})} = N R^2_{xz} \frac{(K(\frac{OR}{1 + K(OR-1)} – 1))^2}{K(1-K) – b^2_{01}}\\)


[^note-id]: Brion M.J., Shakhbazov K. and Visscher P.M. 2013. Calculating statistical power in Mendelian randomization studies. Int J Epidemiol 42(5) 1497-1501.
