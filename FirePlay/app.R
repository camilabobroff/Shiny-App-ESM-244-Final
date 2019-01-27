library(shiny)



ui <- fluidPage(
  leafletOutput("map"),
  fluidRow(
    column(4,
           
           # Date slider 
           sliderInput("date_range", label = "Select Date", min = 2000, 
                       max = 2002, value = c(2000, 2002)))
    )
  )
  


server <- function(input, output, session) {

  #code for reacting with the date slider -- need to figure out how to coerce factor(YEAR_) into numeric so that we can filter
  data_input <- reactive({
    fire_trans_2007 %>% 
      filter( YEAR_ >= as.numeric(input$date_range[1])) %>% 
      filter(YEAR_ <= as.numeric(input$date_range[2]))
  })
  
  #this outputs the map
  output$map <- renderLeaflet({
    leaflet(fire_trans_2007) %>% 
      addTiles() %>%
     addPolygons(
       fill = data_input()$YEAR_
     )
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server)

