
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library("shiny")

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output, session) {
    modelMPG  <- lm(mpg ~ cyl + hp + wt + am + gear, data = cluster.dt)
    modelQSEC <- lm(qsec ~ cyl + hp + wt + am + gear, data = cluster.dt)
    
    # Combine the selected variables into a new data frame
    selectedData <- reactive({
        cluster.dt[, c(input$xcol, input$ycol)]
    })
    
    clusters <- reactive({
        kmeans(selectedData(), input$clusters)
    })
    
    # Prepare prediction dataframe 
    cyl <- reactive({input$cyl})
    hp <- reactive({input$hp})
    wt <- reactive({input$wt/1000})
    am <- reactive({input$am})
    gear <- reactive({input$gear})
    pred <- data.frame(c(cyl,hp,wt,am,gear))
    
    
    output$plot1 <- renderPlot({
        par(mar = c(5.1, 4.1, 0, 1))
        plot(selectedData(),
             col = clusters()$cluster,
             pch = 20, cex = 3)
        points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })
    
    # Estimate MPG and QSEC
    output$mpg_pred <- renderText({
        paste('The simulated car fuel efficiency is ', predict(modelMPG, pred))
    })
    
    output$qsec_pred <- renderText({
        paste('This car would do a 1/4 mile time of ', predict(modelQSEC, pred))
    })
    
    
    
    
})