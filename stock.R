library(shiny)
library(quantmod)

# Source helpers ----

# User interface ----
ui <- fluidPage(
  titlePanel("REVIWER"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a stock to examine.

        Please select write the symbol of the share."),
      textInput("sign", "Symbol", "MSFT"),
      
      selectInput("var", 
                  label = "Choose the indicator to display",
                  choices = c("MACD", 
                              "RSI",
                              "EMA"),
                  selected = "RSI"),
      
      dateRangeInput("TIME",
                     "Duration",
                     start = "2021-01-01",
                     end = as.character(Sys.Date())),
      
      br(),
      br(),
      
      
    ),
    
   
    mainPanel(
      conditionalPanel(
        condition = "input.var == 'MACD'",
        plotOutput("plot1")
      ),
      conditionalPanel(
        condition =  "input.var == 'RSI'",
        plotOutput("plot2")
      ),
      conditionalPanel(
        condition = "input.var == 'EMA'",
        plotOutput("plot3")
      )
    )
)
)


server <- function(input, output) {
  
  dataInput <- reactive({
    getSymbols(input$sign, src = "yahoo",
               from = input$TIME[1],
               to = input$TIME[2],
               auto.assign = FALSE)
  })
  
  output$plot1 <- renderPlot({
    
    chartSeries(dataInput(), theme = chartTheme("black"),
                type = "candlestick", TA= "addMACD()")
    
  })
  output$plot2 <- renderPlot({
    
    chartSeries(dataInput(), theme = chartTheme("black"),
                type = "candlestick", TA="addRSI()")
  
  })
  output$plot3 <- renderPlot({
    
    chartSeries(dataInput(), theme = chartTheme("black"),
                type = "candlestick", TA= "addEMA()")
    
  })
 
  
}

# Run the app
shinyApp(ui, server)



