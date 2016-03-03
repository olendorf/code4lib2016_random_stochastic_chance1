
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

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

shinyServer(function(input, output) {
  
  output$scores <- renderPlot({
    scores = dice.rolls(
      number.dice = input$dice, 
      number.rolls = input$rolls,
      sides = input$sides
      )
    
    bins <- seq(min(scores), max(scores), length.out = input$bins + 1)
    
    if(min(scores) == max(scores))
    {
      bins <- (scores - 2):(scores + 2)
    }
    
    hist(scores, breaks = bins)
    
  })

#   output$distPlot <- renderPlot({
# 
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2]
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
# 
#   })

})
