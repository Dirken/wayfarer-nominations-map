library(shiny)

shinyUI(
  bootstrapPage(
  
    tags$head(
      tags$link(href = "https://fonts.googleapis.com/css?family=Oswald", rel = "stylesheet"),
      tags$style(type = "text/css", "html, body {width:100%;height:100%; font-family: Oswald, sans-serif;}"),
      tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/3.5.16/iframeResizer.contentWindow.min.js",
                  type="text/javascript")
    ),
    
    leafletOutput("map", width = "100%", height = "100%"),
    
    absolutePanel(
      top = 10, right = 10, style = "z-index:500; text-align: right;",
      tags$h2("My Wayspots"),
      tags$a("Based on Crime-Watch", href="https://github.com/PaulC91/crime-watch"),
      br(),
      tags$a("Code repository", href="https://github.com/Dirken/wayfarer-nominations-map"),
      br(),
      tags$a("Wayfarer+", href="https://github.com/MrJPGames/WayFarerPlus")
    ),
    
    absolutePanel(
      top = 100, left = 10, draggable = TRUE, width = "20%", style = "z-index:500; min-width: 300px;",
      fileInput("file", "Browse file")
      #highchartOutput("selectstat")
    )

  )
)
