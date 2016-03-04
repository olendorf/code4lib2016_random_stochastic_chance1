library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = "custom.css",
  
  shinyjs::useShinyjs(),
  

  # Application title
  titlePanel("Random Stocastic Chance"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      wellPanel(
        sliderInput("dice",
                    "Number of Dice",
                    min = 1,
                    max = 20,
                    value = 2),
        
        
        numericInput("rolls",
                    "Number of rolls (Whole Numbers)",
                    min = 1,
                    value = 1000),
        
        selectInput("sides", "Number of Sides", 
                    c(1:20, 22 , 24, 30, 32, 34, 48, 50, 60, 100, 120, 144))
      ),
      
      wellPanel(
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30),
        
        checkboxInput("auto_bins",
                      "Bin Automatically")
      )
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Plot", plotOutput("scores")),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Table", tableOutput("table"))
      )
      
    )
  )
))
