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
  tabPanel("Graphs",
           sidebarLayout(
             sidebarPanel(
               tags$img(src='thomas_fire.jpg', height=150, width=175),
               tags$figcaption("Caption/source")
             ),
             mainPanel(plotOutput("acresPlot"))))))





# Define server logic required to draw a histogram
server <- function(input, output, session) 
{
  
  output$acresPlot <- renderPlot({
    
    # Plot
    ggplot(data = acres, aes(x = YEAR_, y = acres_burn_tot_1000))+
    geom_col(fill = "firebrick1", colour = "firebrick4")+
    theme_classic()+
    scale_x_discrete(expand = c(0,0), limit = c(1877,2017))+
    scale_y_continuous(expand = c(0,0), limit = c(0, 510))+
    labs(y = "Acres Burned (Thousands)", x = "Year")
  })
  
}
  

# Run the application 
shinyApp(ui = ui, server = server)

