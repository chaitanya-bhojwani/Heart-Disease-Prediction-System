
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
 


shinyServer(function(input, output) {
  
  set.seed(1)
  observe({
  knn.pred <- knn(data.frame(train.X[,input$checkGroup]),
                  data.frame(test.X[,input$checkGroup]),
                  train.Y, k = input$k)
 
  # percent error from predictor
  
  # percentage of test set which do NOT say "no" (very small percentage purchase)
  # therefore we are more interested in correct prediction of those which do 
  # purchase 
 
  
  # output$correct.detection <- 100*confusion.matrix[2,2]/sum(confusion.matrix[2,]) 
  # print(correct.detection)
# 
  output$value <- renderText({ paste("Classification Error = ",ce(test.Y,knn.pred)) })
  output$confusionMatrix <- renderDataTable({
    # modify this to show title - confusion matrix
    # /false positive/positive false negative/negative
    true.positive    <- sum(knn.pred == 1 & test.Y == 1)
    false.positive   <- sum(test.Y == 1) - true.positive
    true.negative    <- sum(knn.pred == 0 & test.Y == 0)
    false.negative   <- sum(test.Y == 0) - true.negative
    row.names <- c("Prediction - FALSE", "Prediction - TRUE" )
    col.names <- c("Actual - FALSE", "Actual - TRUE")
    cbind(Outcome = row.names, as.data.frame(matrix( 
      c(true.negative, false.negative, false.positive, true.negative) ,
            nrow = 2, ncol = 2, dimnames = list(row.names, col.names))))
    }, options = table.settings
  )
    
  })
   
   observe({
     
     if(length(input$checkGroup)==0){
       output$distPlot <- NULL
     }
     else if(length(input$checkGroup) == 1){
       output$distPlot <- renderPlot({
         featurePlot(x = train.X[, input$checkGroup],
                     y = factor(train.Y, labels = c("Healthy", "Heart Disease")),
                     scales = list(x = list(relation="free"),
                                   y = list(relation="free")),
                     plot = "density", 
                     auto.key = list(columns = 2) )                                
                                      
                                      })
     }else{
       output$distPlot <- renderPlot({
         featurePlot(x = train.X[, input$checkGroup],
                     y = factor(train.Y, labels = c("Healthy", "Heart Disease")),
                     scales = list(x = list(relation="free"),
                                   y = list(relation="free")),
                     plot = "density", 
                     auto.key = list(columns = 2)
         )  
         
       })
     }
     
   })
})
