library(shiny)
library(shinyjs)

dice.rolls <- function(number.dice = 1, number.rolls = 1, sides=6)
{
  output <- NULL
  if (!is.element(sides, allowable.sides))
  {
    return(paste("Error: ", toString(sides), " is not an allowable number of sides."))
  }
  
  return(replicate(number.rolls, sum(sample(1:sides, number.dice, replace = TRUE))))
  
}


allowable.sides <- c(1:20, 22 , 24, 30, 32, 34, 48, 50, 60, 100, 120, 144)

shinyServer(function(input, output, session) {
  
  # Observer to see if we should disable the bins slider.
  observe({
    if (input$auto_bins == TRUE) {
      shinyjs::disable("bins")
    } else {
      shinyjs::enable("bins")
    }
  })
  
  # Wrapping dice.rolls() inside the reactive method
  # and aliasing it in get.scores() provides a caching method.
  # Unless the actual inputs for dice.rolls() changes this
  # method won't get called again.
  get.scores <- reactive({
    dice.rolls(
      number.dice = input$dice, 
      number.rolls = input$rolls,
      sides = input$sides
    )
  })
  
  output$scores <- renderPlot({
    scores = get.scores()

    
    histogrm <- NULL
    
    # Testing if the bins should be autobinned or not.
    if(input$auto_bins)
    {
      histogrm <- hist(scores)
    }
    else
    {
      histogrm <- hist(scores, breaks = input$bins)
    }
    histogrm
    
  })


})
