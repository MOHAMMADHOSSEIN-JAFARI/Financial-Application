
# Financial Tablet
## Table of contents
*  General Finformation
* Technologies
* Applications
* Sources
### General Finformation:
This ShinyApp includes some Financial tools which can be used in financial analysis. It has three main applications.

### Technologies:
For making this Shinyapp, the "R version 4.0.4" and RStudio "version 1.4.1103" have been used. Moreover, the following packages have been used:

* quantmod
* ggplot2

### Applications


This ShinyApp can be used to watch and analyze the historical data of Microsoft Co. The data is downloaded from the website https://finance.yahoo.com/ by using the famous package Quantmod. For showing better the price of the stocks the candlestick chart has been used. 
Financial indicators: The users can also choose which financial indicator they are interested in to be shown in the chart. 
The financial indicators which have been shown in the selectInput part are RSI, MACD, and EMA which are used highly by analysts and investors. It is also possible for the user to choose the duration of showing the data. 

### Analyzing the 2000-Topest companies:
In the first scatter plot the relationship between the Market value and Sales of the companies has been shown. 
the Users can choose whether they want the data for all the 2000 companies or just the first 100 top companies. 
Analyzing these two factors, Market value and Sales- and the relationship between them are important for investors. 
The second scatter plot shows the figures of assets and profits in billion dollars in 2015.  The user can choose to see the data of this part for all 2000 companies or the 100 topes ones. The figures in this part are in Billion dollars.
The last Table demonstrates a full summary of the data of  2000 companies.

### Investment Calculator:
An investment calculator has been defined by calculating the future value of an investment.
The user-defined function in this part can use compound interest to calculate the future value of the investment.
The users have to choose the 3 main elements:
1- The amount of the money they want to invest
2- The period they want to invest their money 
3- The interest rate of their investment.
Finally, the total amount of the future value of their investment will be shown in the box. 
### Sources
The data for this application has been provided by two methods:
* Using quantmod package to get online data from the website https://finance.yahoo.com/
* Using the .csv file
