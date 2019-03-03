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
library(tidyverse)
library(sf)
library(leaflet)
library(shiny)
library(plotly)
library(spData)
library(varhandle)

fire <- st_read("Fire_Output.shp")

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("sandstone"),

### NEED TO FIX TABS

  # Application title
  navbarPage("Playing with Fire... Data",
        
        sidebarLayout(
             sidebarPanel(
               tags$img(src='justin_sullivan_getty_images.jpg', height=150, width=175),
               tags$figcaption("A firefighter monitoring the Mendocino Complex fire on Aug. 7, 2018. Justin Sullivan/Getty Images")
             ),
             mainPanel("A summary of the app, what it does, how to use it and a description of the data (including citations). Plus small background info paragraph on significance of fires in CA")),
  tabPanel("Map"),
  tabPanel("Graphs")))
  # Sidebar with a slider input for number of bins 
  # sidebarLayout(
  #  sidebarPanel(
  #  selectInput(inputId = "acres_burned",
  #  label = "Acres Burned", 
  #  choices = sort(unique(top100$CAUSE)))),
  #  mainPanel(
  #    plotOutput("acresPlot")




# Define server logic required to draw a histogram
server <- function(input, output, session) 
{}
# Run the application 
shinyApp(ui = ui, server = server)

