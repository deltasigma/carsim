
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Car Performance Analysis and Prediction"),
    
    h4('You can use this app to study how cars caracteristics relates to MPG 
        performance. When you were confident enougth you can estimate a new 
        car performance by using our regression based predictor'),
    
    tabsetPanel(
        tabPanel("Performance",
            sidebarPanel(
                selectInput('xcol', 'X Variable', names(cluster.dt)),
                selectInput('ycol', 'Y Variable', names(cluster.dt),
                            selected=names(cluster.dt)[[2]]),
                numericInput('clusters', 'Cluster count', 3,
                             min = 1, max = 9)
            ),
            mainPanel(
                plotOutput('plot1')
            )
        ),
        tabPanel("Prediction")
    )
))