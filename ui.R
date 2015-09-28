
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
        # This is the first tab on the app screen
        tabPanel("Performance",
            sidebarPanel(
                selectInput('xcol', 'X Variable', c('mpg')),
                selectInput('ycol', 'Y Variable', names(cluster.dt),
                            selected=names(cluster.dt)[[2]]),
                numericInput('clusters', 'Cluster count', 3,
                             min = 1, max = 9)
            ),
            mainPanel(
                plotOutput('plot1')
            )
        ),
        # This is the second tab on the screen
        tabPanel("Prediction",
                 sidebarPanel(
                     # Variables in our model: cyl + hp + wt + am + gear
                     numericInput('cyl','Cylinders',4, min = 2, max = 12),
                     numericInput('hp','Horsepower',120, min = 25, max = 500),
                     numericInput('wt','Weight',2500, min = 1000, max = 6000),
                     selectInput('am','Transmission',c('Automatic','Manual')),
                     #numericInput('am','Transmission',0, min = 0, max = 1),
                     numericInput('gear','Gears',4, min = 2, max = 8)
                 ),
                 mainPanel(
                     verbatimTextOutput('mpg_pred'),
                     verbatimTextOutput('qsec_pred')
                     ))
    )
))