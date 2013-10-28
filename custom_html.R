customHeaderPanel <- function(title, windowTitle = title) {
    tagList(
       tags$head(
          tags$title(windowTitle),
          tags$script(src="https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"),
          tags$script(src="
            var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-45220458-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();")
       ),
       div(class = "span12", style = "padding: 10px 0px;", h1(title))
    )
}