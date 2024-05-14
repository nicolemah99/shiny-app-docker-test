library(renv)
library(shiny)
library(ggplot2)

# Define UI for application
ui <- fluidPage(
  # Application title
  titlePanel("Random Data Bar Graph"),
  
  # Sidebar with a button to generate new data
  sidebarLayout(
    sidebarPanel(
      actionButton("newdata", "Generate New Data")
    ),
    
    # Show a plot of the generated data
    mainPanel(
      plotOutput("barPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  data <- reactiveVal(data.frame(x = LETTERS[1:5], y = runif(5, 1, 100)))
  
  observeEvent(input$newdata, {
    # Generate new random data
    data(data.frame(x = LETTERS[1:5], y = runif(5, 1, 100)))
  })
  
  output$barPlot <- renderPlot({
    ggplot(data(), aes(x = x, y = y)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Random Data Bar Graph", x = "Category", y = "Value")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
