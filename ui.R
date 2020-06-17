#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Diamond price application"),
    
    # Sidebar with options selectors 
    sidebarLayout(
        sidebarPanel(
            h4(helpText("This application predicts the price of a diamond based on user's inputs.")),
            helpText("Select carat, cut and color of your choice and press the submit button to get the predicted Diamond price."),
            #slider for carat selection
            sliderInput("Dcarat", h3("Diamond Carat"), 0.2, 5.01, value = 1),
            
            #Radiobuttons for cut selection
            radioButtons("Dcut", h3("Diamond Cut"),
                         choices = list( "Fair" = "Fair", "Good" = "^Good",
                                         "Very Good" = "Very Good", "Premium" = "Premium",
                                         "Ideal" = "Ideal")),
            #Radiobuttons for color selection
            radioButtons("Dcolor", h3("Diamond Color"),
                         choices = list( "D" = "D", "E" = "E",
                                         "F" = "F", "G" ="G",
                                         "H" = "H", "I" = "I",
                                         "J" = "J")),
            #Adding submit button for delayed reactivity
             submitButton("Submit")
        ),
        
        # Output - plot, values, final price
        mainPanel(
            plotOutput("DiamondPlot"),
            h3("For the selected values of"),
            h3("Carat, Cut & Color"),
            h3(textOutput("value")),
            h3("Predicted value of the diamond is:",style = "color:red"),
            h3(textOutput("result"),style = "color:red"),
            
        )
    )
))
