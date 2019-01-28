library(shiny)
library(tidyverse)
library(sf)
library(leaflet)
library(tmap)
library(plotly)

#####to do list:
#mutate $Shape_area from sq. m to acres sq.
#consider: changing from polygons to points - might render faster in the app


fire_year <- fire %>% 
  select(YEAR_, FIRE_NAME, Shape_Area) %>% 
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
        popup = paste("<h4> Fire Description </h4>", "<p>Fire name:</P>", fire_year$FIRE_NAME, "<p> Year: </>", fire_year$YEAR_, "<p>Size:</p>", fire_year$Shape_Area, "sq. meters"),
       options =  popupOptions(maxWidth = 1000) #need to adjust the pop up asthetics
      )
   
  })
  
  

  

}

# Run the application 
shinyApp(ui = ui, server = server)

