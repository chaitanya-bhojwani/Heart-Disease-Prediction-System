
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Classification of Heart Disease - KNN"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("k","number of neighbors",min = 1,max = 20,value = 5),
      checkboxGroupInput("checkGroup", label = h3("Dataset Features"), 
                         choices = feature.list, inline = T,
                         selected = "age")
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
      tabPanel("Confusion Matrix",dataTableOutput('confusionMatrix')),
      tabPanel("Classification Error", p('K-Nearest Neighbors...'),verbatimTextOutput("value")),
      tabPanel("Plots",plotOutput("distPlot"))
      #dataTableOutput('confusionMatrix'),
      #p('K-Nearest Neighbors...'),
      #verbatimTextOutput("value"),
      #plotOutput("distPlot")
    )
  )
  
))
)
