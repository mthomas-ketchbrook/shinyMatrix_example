library("shiny")
library("shinyMatrix") 

m <- matrix(
  runif(12), 
  6, 
  2, 
  dimnames = list(
    NULL, 
    c("x", 
      "y")
  )
) 

ui <- fluidPage(
  titlePanel("shinyMatrix: Simple App"),
  sidebarPanel(
    width = 6,
    tags$h4("Data"),
    matrixInput(
      "sample",
      value = m,
      rows = list(extend = TRUE),
      cols = list(names = TRUE)
    ), 
    shiny::actionButton(
      inputId = "update_chart", 
      label = "Update Chart"
    )
  ),
  mainPanel(
    width = 6,
    plotOutput("scatter")
  )
) 

server <- function(input, output, session) {
  
  mat <- shiny::eventReactive(input$update_chart, {
    
    input$sample
    
  }, ignoreNULL = F)
  
  output$scatter <- renderPlot({
    plot(
      mat(),
      col = "red",
      main = "Scatterplot"
    )   
  })
  
} 

shinyApp(ui, server) 
