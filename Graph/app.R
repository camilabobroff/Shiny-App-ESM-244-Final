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
    
  navbarPage("Playing with Fire... Data",
             
             sidebarLayout(
               sidebarPanel(
                 tags$img(src='thomas_fire.jpg', height=150, width=175),
                 tags$figcaption("caption/source")
               ),
               mainPanel("plot")),
             tabPanel("Map"),
             tabPanel("Graphs")))
# Define a server for the Shiny app
server <- function(input, output, session) {
  
  output$acresPlot <- renderPlot({
  
  # Plot
   # ggplot(data = acres, aes(x = YEAR_, y = acres_burn_tot_1000))+
    # geom_col(fill = "firebrick1", colour = "firebrick4")+
    # theme_classic()+
    # scale_x_discrete(expand = c(0,0), limit = c(1877,2017))+
   # scale_y_continuous(expand = c(0,0), limit = c(0, 510))+
    #labs(y = "Acres Burned (Thousands)", x = "Year")
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

