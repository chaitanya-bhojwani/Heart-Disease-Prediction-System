shinyServer(function(input, output) {
  
  set.seed(1)
  
  observe({
    
      output$fulltree1 <- renderPlot({
        fulltree = rpart(chd ~ ., data = train , method= "class")
        prp(fulltree)
      })
  })
})