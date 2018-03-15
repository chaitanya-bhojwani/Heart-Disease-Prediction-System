library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Classification Tree of Dataset - Decision Tree"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel("Decision Tree Plots"
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Decision Tree Plot - Type 1",plotOutput("fulltree1"))
      )
    )
    
  ))
)
