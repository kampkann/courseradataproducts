# kannan sundararaman ~ global declaration ~ developing data products project ~ coursera
# 21-June-2015

library(shiny)

# Rely on the dataset declared on global.R

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Seleted text display
  output$selectext <- renderText({
        paste("You have selected", input$xstate, input$xyear, input$xcrop )
        #summary(df.apy)
        
        })
    
# Trying to plot 
 output$cropplot <- renderPlot({
#     Render a barplot
#     Plot 2 data -> State & Crop for each year -- subset is enough
#     
#     

   ### data frame extractions 
   
   # Plot1 All state, all year crop average production 
   
   df.Plot1 <- aggregate(Produced~Crop, data=df.apy, mean) 
   
   # Plot 2 data -> State & Crop for each year -- subset is enough

   df.Plot2 <- subset( x = df.apy, 
                       subset = trim(State) == input$xstate & Crop == input$xcrop, 
                       select = c("Year", "Produced"),
                       na.rm = TRUE
   )
  
   # Plot 3 <- Top 10 States which produced the Crop for the year
   # x <- x[with(x, order(yearrank, Year)), ] -- sample ordering 
   
   df.Plot3 <- df.apy[ df.apy$Crop == input$xcrop & df.apy$Year == input$xyear,  ]
   df.Plot3 <- df.Plot3[ with(df.Plot3, order(Staterank) ),  ]
   df.Plot3 <- df.Plot3[ 1:10,  ]
   
   # Plot 4 <- for the state and the year - all crops are produced 
   # x <- x[with(x, order(yearrank, Year)), ] -- sample ordering 
   
   df.Plot4 <- df.apy[ df.apy$State == input$xstate & df.apy$Year == input$xyear,  ]
   
   
   ###

   
   if( input$xplot == "plot1" & nrow(df.Plot1) != 0 ){
     
   ##  Plotting the all india production of all crops in all year
   
   barplot( df.Plot1$Produced,
              ,names.arg=df.Plot1$Crop
              ,yaxt="n"
              ,cex.axis = 1
              ,cex.names = .75
              ,main = paste("All India grain crop production between 1998 - 2009" )
              ,xlab = "Crops"
              ,ylab = "Qty In Metric Ton"
              ,col=terrain.colors(8)
   )
   axis(2, axTicks(2), format(axTicks(2), scientific = F))
   box()
   }
   
   if( input$xplot == "plot2" & nrow(df.Plot2) != 0){
   barplot( df.Plot2$Produced,
              ,names.arg=df.Plot2$Year
              ,yaxt="n"
              ,cex.axis = 1
              ,cex.names = 1
              ,main = paste(input$xcrop,  " Production in " , input$xstate )
              ,xlab = "Year"
              ,ylab = "Qty In Metric Ton"
              ,col=terrain.colors(8)
   )
   axis(2, axTicks(2), format(axTicks(2), scientific = F))
   box()  
   
   }
   
   if( input$xplot == "plot3" & nrow(df.Plot3) != 0 ){
     
   bp <- barplot( df.Plot3$Produced,
            ,names.arg=df.Plot3$State
            ,axes = FALSE, axisnames = FALSE 
            ,main = paste(input$xyear, " ", input$xcrop, " Production in all states " )
            ,xlab = "State"
            ,ylab = "Qty In Metric Ton"
            ,col=terrain.colors(8)
   )
   text(bp, par("usr")[3] - 1.5, labels = df.Plot3$State, srt = 45, adj = 1.05, xpd = TRUE, cex=1)
   axis(2, axTicks(2), format(axTicks(2), scientific = F))
   box()
   
   }
   
   if( input$xplot == "plot4" & nrow(df.Plot4) != 0){
   
  bp <- barplot( df.Plot4$Produced,
            ,names.arg=df.Plot4$Crop
            ,yaxt="n"
            ,axes = FALSE, axisnames = FALSE 
            ,cex.axis = 1
            ,cex.names = 1
            ,main = paste(input$xyear, " ", input$xstate, " Production of all Crops " )
            ,xlab = "Crops"
            ,ylab = "Qty In Metric Ton"
            ,col=terrain.colors(8)
   )
   text(bp, par("usr")[3] - 1.5, labels = df.Plot4$Crop, srt = 45, adj = 1.05, xpd = TRUE, cex=1)
   axis(2, axTicks(2), format(axTicks(2), scientific = F))
   box()
   
   }   
   

   })

## Summary page 

# Seleted text display
  output$summary <- renderText({
    summary(df.apy)
  })
  
})