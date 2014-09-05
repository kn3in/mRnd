customHeaderPanel <- function(title, windowTitle = title) {
    tagList(
       tags$head(
          tags$title(windowTitle),
          tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"),
          tags$script(src="js/ga.js")
       ),
       div(class = "span12", style = "padding: 10px 0px;", h1(title))
    )
}