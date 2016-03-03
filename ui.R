
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  allowable.sides <- c(1:20, 22 , 24, 30, 32, 34, 48, 50, 60, 100, 120, 144),

  # Application title
  titlePanel("Random Stocastic Chance"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("dice",
                  "Number of Dice",
                  min = 1,
                  max = 20,
                  value = 2),
      
      
      numericInput("rolls",
                  "Number of Rolls (Whole Numbers)",
                  min = 1,
                  value = 1000),
      
      selectInput("sides", "Number of Sides", allowable.sides),
      
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scores")
    )
  )
))
