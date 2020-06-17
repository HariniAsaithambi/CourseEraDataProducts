library(shiny)
library(ggplot2)
library(dplyr)
#  columns carat,cut, color and price are used in the analysis
newDiamonds <- diamonds[,c(1:3,7)]
# server logic for plot
shinyServer(function(input, output) {
  output$DiamondPlot <- renderPlot({
    # select values based on user input
    newDiamonds <- filter(diamonds, grepl(input$Dcut, cut), grepl(input$Dcolor, color))
    # run near regression model
    lmfit <- lm( price~carat, newDiamonds)
    #  prediction with the new input values
    predprice <- predict(lmfit, newdata = data.frame(carat = input$Dcarat,
                                              cut = input$Dcut,
                                              color = input$Dcolor))
    # ploting the predicted values 
    plot <- ggplot(data=newDiamonds, aes(x=carat, y = price))+
      geom_point(aes(color = cut), alpha = 0.3)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$Dcarat, color = "orange")+
      geom_hline(yintercept = predprice, color = "red")
    plot
  })
  
  #Rendering the selected values
  output$value <- renderText({
    value<-c(input$Dcarat,",",input$Dcut,"&",input$Dcolor)
    value   
  })
  
 # prediction for displaying the final result
   output$result <- renderText({
    newDiamonds <- filter(diamonds, grepl(input$Dcut, cut), grepl(input$Dcolor, color))
    lmfit <- lm( price~carat, newDiamonds)
    predprice <- predict(lmfit, newdata = data.frame(carat = input$Dcarat,
                                             cut = input$Dcut,
                                              color = input$Dcolor))
    res <- paste(round(predprice, digits = 1), "$")
    res
  })
 
  
})
