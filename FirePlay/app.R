library(shiny)
library(tidyverse)
library(sf)
library(leaflet)
library(tmap)
library(plotly)

#####to do list:
#mutate $Shape_area from sq. m to acres sq.
#redefine cause codes from $CAUSE to actual definitions so that the cause can be clearly stated in the popup
#consider: changing from polygons to points - might render faster in the app
#####can then add each fire using addCircleMarkers
#consider also: do we want to onl include say, the largest 1000 fires in history range?


fire_year <- fire %>% 
  select(YEAR_, FIRE_NAME, Shape_Area, CAUSE) %>% 
  filter(YEAR_ ==  "2000" | YEAR_ == "2001" | YEAR_ == "2002" | YEAR_ == "2003")


#change projection to be compatible with leaflet
fire_year <- st_transform(fire_year, crs = 4326)

ui <- fluidPage(
  titlePanel("California Fires"),
  sidebarLayout(position = "left",
    mainPanel(leafletOutput("map")),
    sidebarPanel( 
           
           # Date slider 
           sliderInput("date_range", 
                       label = "Select Date", 
                       min = 2000, 
                       max = 2003,
                       value = c(2000, 2003)),
           
    # search bar based on fire names
    tags$div(title = "Search by name of fire", #this creates an information box that displays the text when hovering over the widget 
             selectInput(inputId = "fire", 
                         label = "Fire Name", 
                         choices = sort(unique(fire_year$FIRE_NAME))))
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
    leaflet(fire_year) %>% 
      addProviderTiles("Esri.WorldTopoMap") %>% 
      addPolygons(
        fillColor = ~pal(fire_year$YEAR_),
        popup = paste("<h3 style = 'color: red'> Fire Description </h3>", "<b>Fire name:</b>", fire_year$FIRE_NAME, "<br", "<b>Year:</b>", fire_year$YEAR_,"<br>", "<b>Size:</b>", fire_year$Shape_Area, "Sq.Meters", "<br>", "<b>Cause code</b>", fire_year$CAUSE, sep = " ") 
      )
   
  })
  
  

  

}

# Run the application 
shinyApp(ui = ui, server = server)

