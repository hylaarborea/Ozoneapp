library(shiny)
shinyServer(function(input, output) {


    model1 <- reactive({
        brushed_data <- brushedPoints(airquality, input$brush1,
                                      xvar = input$variable, yvar = "Ozone")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        

        lm(Ozone ~ eval(as.symbol(input$variable)), data = brushed_data)
    })
    
    

    model2 <- reactive({
        brushed_data <- brushedPoints(airquality, input$brush1,
                                      xvar = input$variable, yvar = "Ozone")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        

        #lm(Ozone ~ xx + I(xx^2) + I(xx^3), data = brushed_data)
        lm(Ozone ~ eval(as.symbol(input$variable)) +
               I(eval(as.symbol(input$variable))^2) +
               I(eval(as.symbol(input$variable))^3), 
           data = brushed_data)
    })
    

    fractionPoints <-reactive({
        if(!is.null(model2())){
            brushed_data <- brushedPoints(airquality, input$brush1,
                                          xvar = input$variable, yvar = "Ozone")
            
            npart<-dim(brushed_data)[1]
            ntot<-dim(airquality)[1]
            
            round(npart/ntot*100,digits = 2)
        }
    })
    
    
    

    model1pred <- reactive({
        if(!is.null(model1())){
            solarInput <- input$sliderSolar
            windInput <- input$sliderWind
            tempInput <- input$sliderTemp

            predict(model1(), newdata = data.frame(Solar.R = solarInput, 
                                                  Wind = windInput,
                                                  Temp=tempInput))

        }
    })


    
    
    model2pred <- reactive({
        if(!is.null(model2())){
            solarInput <- input$sliderSolar
            windInput <- input$sliderWind
            tempInput <- input$sliderTemp

            predict(model2(), newdata = data.frame(Solar.R = solarInput, 
                                                   Wind = windInput,
                                                   Temp=tempInput))
        }
    })
    
    
        
    
        
    output$plot1 <- renderPlot({
        solarInput <- input$sliderSolar
        windInput <- input$sliderWind
        tempInput <- input$sliderTemp
        
        plot(x=airquality[,input$variable], airquality$Ozone, 
             xlab = input$variable, 
             ylab = "Ozone", bty = "n", pch = 16, 
             ylim = c(0, 170))
        
        if(input$showModel1){
            abline(model1(), col = "red", lwd = 2)
        }
        
        

        
        if(input$showModel2){
            if(!is.null(model2())){
    
                vals=range(airquality[,input$variable], na.rm = T)
                xx=min(vals):max(vals)

                model2lines <- predict(model2(), 
                    newdata = data.frame(Solar.R = xx, Wind = xx, Temp = xx))
                
                
               lines(xx, model2lines, col = "blue", lwd = 2)
           }
        }

        
        if(input$variable == "Solar.R"){
            varIn<-solarInput
        } else if(input$variable == "Wind"){
            varIn<-windInput
        } else if (input$variable == "Temp"){
            varIn<-tempInput
        }
        
                
        lx=(min(airquality[,input$variable], na.rm = T)+
                max(airquality[,input$variable], na.rm = T))/2
        lx=min(airquality[,input$variable], na.rm = T)
        ly=max(airquality$Ozone, na.rm = T)

        
        legend(x=lx,y=ly, legend =  c("Model 1 Prediction", "Model 2 Prediction"), 
               pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
 
                   
        
        if(input$showModel1){
            if(!is.null(model1())){
                points(varIn, model1pred(), col = "red", pch = 16, cex = 2)
            }
        }
        
        if(input$showModel2){
            if(!is.null(model2())){
                points(varIn, model2pred(), col = "blue", pch = 16, cex = 2)
            }
        }
        
    })

    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })

    
    output$frac <- renderText({
            fractionPoints()   
    })
    
    
})

