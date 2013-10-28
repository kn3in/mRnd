library(shiny)
library(knitr)
source("custom_html.R")

shinyUI(pageWithSidebar(
  customHeaderPanel("mRnd: Power calculations for Mendelian Randomization"),
    
  sidebarPanel(
      h4("Input"),
      wellPanel(
        h6("Calculate:"),
        radioButtons("my_method", "",
                       list("Power" = "power",
                            "Sample size" = "samp_size")),
        h6("Provide:"), 
      conditionalPanel(condition = 'input.my_method == "power"',
                       numericInput("N", "Sample size", min = 1, value = 1000, step = 1)),
      conditionalPanel(condition = 'input.my_method == "samp_size"',
                       numericInput("epower", "Power", min = 0, max = 1, value = 0.8))),

      wellPanel(numericInput("alpha", HTML("\\(\\alpha\\)"), min = 0, max = 1, value = 0.05),
                helpText("Type-I error rate")),
      
      wellPanel(numericInput("byx", HTML("\\(\\beta_{yx}\\)"), value = 0),
                helpText("The regression coefficient \\(\\beta_{yx}\\) for the true underlying causal association between the exposure \\((X)\\) and outcome \\((Y)\\) variables")),
      
      wellPanel(numericInput("bOLS", HTML("\\(\\beta_{OLS}\\)"), value = 0),
                helpText("The regression coefficient \\(\\beta_{OLS}\\) for the observational association between the exposure \\((X)\\) and outcome \\((Y)\\) variables")),
      
      wellPanel(numericInput("R2xz", HTML("\\(R^2_{xz}\\)"), min = 0, max = 1, value = 0.01),
                helpText("Proportion of variance explained for the association between the snp \\((Z)\\) and the exposure variable \\((X)\\)")),
      
      wellPanel(numericInput("varx", HTML("\\(\\sigma^2(x)\\)"), value = 1),
                helpText("Variance of the exposure variable \\((X)\\)")),
      
      wellPanel(numericInput("vary", HTML("\\(\\sigma^2(y)\\)"), value = 1),
                helpText("Variance of the outcome variable \\((Y)\\)"))),
  
  mainPanel(
        wellPanel(
            h4("Two-stage least squares"),
            tableOutput("result"),
            HTML("
  Power or sample size calculations for two-stage least squares Mendelian Randomization studies using a genetic instrument \\(Z\\) (a SNP or allele score),
  a continuous exposure variable \\(X\\) (e.g.  body mass index [BMI, \\(\\frac{kg}{m^2}]\\)) and
  a continuous outcome variable \\(Y\\) (e.g. blood pressure [mmHg]).")),
          wellPanel(
            h4("YZ association"),
            tableOutput("result_beta"),
            HTML("Power or sample size calculations for the regression association of a genetic instrument \\(Z\\) (e.g. a BMI SNP), with a continuous outcome variable \\(Y\\) (blood pressure).")),
        wellPanel(h4("Working Example"),
          p("If we are interested in calculating the minimum required sample size for performing a Mendelian Randomization (MR) study ascertaining the causal effects of body mass index (BMI) on  systolic blood pressure (SBP) in children, the required parameters for this online calculator could be taken from, for example, results from a published observational epidemiology study reporting associations between BMI and SBP and a SNP instrument that is reliably associated with BMI."),
p("In an observational study reporting the association of BMI and SBP in children\\(^{[1]}\\), the regression coefficients for the association between BMI and SBP (averaged coefficients for boys and girls) was observed to be \\(1.41 \\frac{mmHg}{SD}\\) (no confounder-adjustment) and \\(1.30 \\frac{mmHg}{SD}\\) \\(^{[*]}\\) (adjusted for confounders). The SD for SBP in this sample (from the paper’s online supplementary data) was \\(10.8\\), with an SD (standard deviation) of \\(1\\) for BMI."),
p("Assume that the causal effect of BMI on SBP is \\(1.30 \\frac{mmHg}{SD}\\) \\(^{[*]}\\) and that the population regression coefficient of BMI on SBP, including the effects of confounders, is \\(1.41 \\frac{mmHg}{SD}\\). Also assume that for the MR study we have a genetic instrument that explains \\(R^2_{xz} = 0.01\\) of variation in BMI (based on e.g. FTO SNP, which explains \\(\\sim 1 \\%\\) of the variation in BMI)\\(^{[2]}\\). Then we can calculate the power of an MR study using the following  parameters:"),

p("\\(\\beta_{OLS} = 1.41 \\frac{mmHg}{SD}\\)"),
p("\\(\\beta_{yx} = 1.3 \\frac{mmHg}{SD}\\) \\(^{[*]}\\)"),
p("\\(\\sigma^2(x) = 1\\)"),
p("\\(\\sigma^2(y) = 10.8^2 = 116.6~mmHg^2\\)"),

p("For an \\(\\alpha\\) of \\(0.05\\) and power of \\(0.8\\), the calculated minimum sample size for the Mendelian Randomization study is \\(N = 53,218\\). The reason why this sample size is so large is because BMI explains a small amount of variation in SBP in this case and because the genetic instrument explains a small proportion of variance in BMI."),
p("\\(*\\) \\(\\beta_{yx}\\) refers to the unknown true causal association between \\(X\\) and \\(Y\\) (between BMI and blood pressure, in this example) and therefore instead of 1.3 mmHg one could potentially use any value of \\(\\beta_{yx}\\) deemed plausible or, for example, inspect the power/sample size calculations for a range of hypothetical values of \\(\\beta_{yx}\\)."),
p("1. Lawlor DA, Benfield L, Logue J et al. ", a(href="http://www.bmj.com/content/341/bmj.c6224", "Association between general and central adiposity in childhood, and change in these, with cardiovascular risk factors in adolescence: prospective cohort study."), " BMJ 2010; 341: c6224."),
p("2. Frayling TM, Timpson NJ, Weedon MN et al.", a(href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2646098/", "A Common variant in the FTO gene is associated with body mass index and predisposes to childhood and adult obesity."), "Science 2007; 316(5826): 889-894.")),
        wellPanel(h4("Citation"),
        p(a(href="http://ije.oxfordjournals.org/content/42/5/1497.abstract", "Calculating statistical power in Mendelian randomization studies"), "Marie-Jo A Brion, Konstantin Shakhbazov, Peter M Visscher", "International Journal of Epidemiology 2013 42: 1497-1501")),
        wellPanel(p(a(href="https://github.com/kn3in/mRnd", "Source code at GitHub")))
)))