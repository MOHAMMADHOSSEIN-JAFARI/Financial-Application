library(shiny)
library(quantmod)
library(ggplot2)
Top100_company= read.csv("data/100 Topest.csv")
Top2000_company= read.csv("data/2000 Topest.csv")

ui <- fluidPage(
  titlePanel("Financial_Tablet"),
  
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
      
      selectInput("companies", 
                  label = "Plots of Topest Companies in 2015",
                  choices = c("Top-2000", 
                              "Top-100"),
                  selected = "Top-2000"),
      
      
      
      helpText("Calculate the future value of your investment"),
      numericInput(inputId = "investment" , label = "how much do you want to invest", value = 1000),
      
      
      numericInput(inputId = "investmetn_duration", label = "choose the years of investment", value = 0),
      
      
      numericInput(inputId = "interest_rate", label = "write the amount of interest rate in percent", value = 0),
      helpText("The following box shows the future value of your investment"),
      
      verbatimTextOutput("final_investment"),
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
      ),
      br(),
      br(),
      
      
      
      
      conditionalPanel(
        condition = "input.companies == 'Top-2000'",
        plotOutput("plot4")
      ),
      
      conditionalPanel(
        condition = "input.companies == 'Top-100'",
        plotOutput("plot5")
      ),
      
      conditionalPanel(
        condition = "input.companies == 'Top-2000'",
        plotOutput("plot6")
      ),
      conditionalPanel(
        condition = "input.companies == 'Top-100'",
        plotOutput("plot7")
      ),
      
      verbatimTextOutput("summary2000"),
      
      
    ) 
    
  )
)

final_investment<- function(investment,investment_duration, interest_rate  ){ 
  investment*(1+interest_rate/100)^investment_duration}

summary2000<- summary(Top2000_company)


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
  
  output$plot4 <- renderPlot({ ggplot(Top2000_company, aes(x= Sales, y= Market.Value))+ geom_point(aes(color = factor(Sector)))+ggtitle("Market value and Sales of top 2000 companies in 2015") +theme_classic() + labs(subtitle="Classic Theme")+ theme(axis.text=element_text(size=12),
                                                                                                                                                                                                                                                        axis.title=element_text(size=14,face="bold"))
   
    
    
  })
  
  output$plot5 <- renderPlot({ ggplot(Top100_company, aes(x= Sales, y= Market.Value))+ geom_point(aes(color = factor(Sector)))+ggtitle("Market value and Sales of top 100 companies in 2015")+theme_classic() + labs(subtitle="Classic Theme")+ theme(axis.text=element_text(size=12),
                                                                                                                                                                                                                                                     axis.title=element_text(size=14,face="bold"))
    
    
  })
  
  output$plot6 <- renderPlot({ ggplot(Top2000_company, aes(x= Assets, y= Profits ))+ geom_point(aes(color = factor(Continent)), size=2)+ggtitle("Profit and Sales of top 2000 companies in 2015")+ labs(subtitle="Classic Theme")+ theme(axis.text=element_text(size=12),
                                                                                                                                                                                                                                        axis.title=element_text(size=14,face="bold"))
    
    
    
  })
  output$plot7 <- renderPlot({ ggplot(Top100_company, aes( x= Assets, y= Profits ))+ geom_point(aes(color = factor(Continent)), size=2)+ggtitle("Profit and Sales of top 100 companies in 2015")+ labs(subtitle="Classic Theme")+ theme(axis.text=element_text(size=12),
                                                                                                                                                                                                                                       axis.title=element_text(size=14,face="bold"))
    
    
    
  })
  
  investment    <- reactive({input$investment})
  investmetn_duration  <- reactive({input$investmetn_duration})
  interest_rate <- reactive({input$interest_rate})  
  output$final_investment <- renderPrint({final_investment(input$investment, input$investmetn_duration, input$interest_rate)})
  
  summary2000 <- summary(Top2000_company)
  
  output$summary2000 <- renderPrint({summary2000})
  
}

# Run the app
shinyApp(ui, server)

