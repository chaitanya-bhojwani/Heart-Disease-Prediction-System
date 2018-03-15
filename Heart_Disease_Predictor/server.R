#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ElemStatLearn)
data(SAheart)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  model1 <- glm(chd ~ age + alcohol + obesity + tobacco + typea, family = "binomial",data = SAheart)
  
  model1pred <- reactive({
    ageInput <- input$slider1
    alcoholInput <- input$slider2
    obesityInput <- input$slider3
    tobaccoInput <- input$slider4
    typeaInput <- input$slider5
    
    predict(model1,
            newdata = data.frame(age = ageInput, alcohol = alcoholInput, obesity = obesityInput,
                                 tobacco = tobaccoInput, typea = typeaInput ))
  })
  
  output$pred1 <- renderText({
    exp(model1pred())/(1+exp(model1pred()))*100
    # generate bins based on input$bins from ui.R
  })
  
})
