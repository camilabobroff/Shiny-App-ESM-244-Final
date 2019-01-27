#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram

ui <- fluidPage(
  leafletOutput("map")
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
   
    leaflet(fire_trans_2007) %>% addTiles() %>%
     addPolygons()
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server)

