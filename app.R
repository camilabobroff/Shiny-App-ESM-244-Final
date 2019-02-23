#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("sandstone"),
  
  
  # Application title
  navbarPage("Playing with Fire... Data",
             
             sidebarPanel(
               tags$img(src='justin_sullivan_getty_images.png', height=200, width=200),
               tags$figcaption("Justin Sullivan/Getty Images")
             )
  ),
  mainPanel(
    uiOutput
  )
  tabPanel("Map"),
  tabPanel("Graphs")
  # Sidebar with a slider input for number of bins 
  # sidebarLayout(
  #  sidebarPanel(
  #  selectInput(inputId = "acres_burned",
  #  label = "Acres Burned", 
  #  choices = sort(unique(top100$CAUSE)))),
  #  mainPanel(
  #    plotOutput("acresPlot")
)



# Define server logic required to draw a histogram
server <- function(input, output, session) { # Added session to see if it would help render the image
  output$Image <- renderImage({
    filename <- normalizePath(file.path('./www', 
                                        paste('image', input$n, '.png', sep='')))
    
    list(src = filename)
    
  }, deleteFile = FALSE)
  
}
# Run the application 
shinyApp(ui = ui, server = server)

