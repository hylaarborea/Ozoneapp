library(shiny)
shinyUI(fluidPage(
    sidebarLayout(
        sidebarPanel(
            
            selectInput("variable", "Choose the predictor variable:",
                        c("Solar radiation" = "Solar.R",
                          "Wind" = "Wind",
                          "Temperature" = "Temp")),
            
            br(),
            
            h4("Choose now its value:"),
            
            
            
            sliderInput("sliderSolar", "Solar Radiation  
                        (in Langleys units) ?", 0, 340, value = 170),
            
            sliderInput("sliderWind", "Wind (in mph)?", 0, 25, 
                        value = 12),
            
            sliderInput("sliderTemp", "Temperature (in F)?", 55, 100, 
                        value = 77),
            
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            
            br(),
            
            h4("Select the points with your mouse!!!")
            
        #    submitButton("Submit")
        ),
        
        
        mainPanel(
            titlePanel(HTML("<center>Predict the concentration of Ozone (in ppb)</center>")),
            plotOutput("plot1", brush = brushOpts(
                id = "brush1")),
            h3("You have selected the following percentage of points:"),
            textOutput("frac"),
            h3("Predicted Ozone from Model 1 (linear):"),
            textOutput("pred1"),
            h3("Predicted Ozone from Model 2 (cubic):"),
            textOutput("pred2")
            
        )
    )
))
