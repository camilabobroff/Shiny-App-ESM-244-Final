library(shiny)



ui <- fluidPage(
  titlePanel("California Fires"),
  sidebarLayout(
    mainPanel(leafletOutput("map")),
    sidebarPanel( 
           
           # Date slider 
           sliderInput("date_range", 
                       label = "Select Date", 
                       min = 2000, 
                       max = 2002,
                       value = c(2000, 2002)),
           
    # search bar based on fire names
    tags$div(title = "Search by name of fire", #this creates an information box that displays the text when hovering over the widget
             selectInput(inputId = "fire", 
                         label = "Fire Name", 
                         choices = sort(unique(fire_trans_2007$FIRE_NAME))))
    )
  )
)


server <- function(input, output) {

  
  
  #this outputs the map
  output$map <- renderLeaflet({
    
    
    #allows user to highlight a polygon based on the selected date range
    pal <- colorFactor(
      palette = "Red",
      domain = input$date_range
    )
    
    #renders the map
    leaflet(fire_trans_2007) %>% 
      addProviderTiles("Esri.WorldTopoMap") %>% 
      addPolygons(
        fillColor = ~pal(fire_trans_2007$YEAR_)
      )
  })
  
  

  

}

# Run the application 
shinyApp(ui = ui, server = server)

