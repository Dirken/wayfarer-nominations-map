library(shiny)

shinyUI(
  bootstrapPage(
  
    tags$head(
      tags$link(href = "https://fonts.googleapis.com/css?family=Oswald", rel = "stylesheet"),
      tags$style(type = "text/css", "html, body {width:100%;height:100%; font-family: Oswald, sans-serif;}"),
      tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/3.5.16/iframeResizer.contentWindow.min.js",
                  type="text/javascript"),
      tags$script('
                  $(document).ready(function () {
                    navigator.geolocation.getCurrentPosition(onSuccess, onError);
                    
                    function onError (err) {
                      Shiny.onInputChange("geolocation", false);
                    }
                    
                    function onSuccess (position) {
                      setTimeout(function () {
                        var coords = position.coords;
                        console.log(coords.latitude + ", " + coords.longitude);
                        Shiny.onInputChange("geolocation", true);
                        Shiny.onInputChange("lat", coords.latitude);
                        Shiny.onInputChange("long", coords.longitude);
                      }, 1100)
                    }
                  });
      ')
    ),
    
    leafletOutput("map", width = "100%", height = "100%"),
    
    absolutePanel(
      top = 10, right = 10, style = "z-index:500; text-align: right;",
      tags$h2("My Wayspots"),
      tags$a("Repository", href="https://github.com/Dirken/wayfarer-nominations-map")
    ),
    
    absolutePanel(
      top = 100, left = 10, draggable = TRUE, width = "20%", style = "z-index:500; min-width: 300px;",
      checkboxInput("use_location", "Or use your current location?"),
      fileInput("file", "Browse file")
      #highchartOutput("selectstat")
    )

  )
)
