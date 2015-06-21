# kannan sundararaman ~ global declaration ~ developing data products project ~ coursera
# 21-June-2015

library(shiny)

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).

library(datasets)
library(markdown)

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Grain Crop production in India between 1998 and 2010"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        helpText("Select state, year and the crop ..."),
        hr(),
        selectInput("xstate", "State:", 
                    choices=statelist),
        hr(),
        selectInput("xyear", "Year:", 
                    choices=yearlist),
        
        hr(),
        selectInput("xcrop", "Grain Crop:", 
                    choices=croplist),
        
        hr(),
        radioButtons("xplot", "Plot Selection", c("All India all crops" = "plot1",
                                                  "Selected state, crop yearwise" = "plot2",
                                                  "Top states for year and crop" = "plot3",
                                                  "For the state and Year all crops" = "plot4"
                                                  ), selected = "plot2" , inline = FALSE),
        
        hr()
        
        
      ),
      
      # Plot and mark down file for documentation 
      mainPanel(
        tabsetPanel(
          tabPanel("Plot", plotOutput("cropplot") ),
          tabPanel("Readme", 
                   fluidRow(
                     column(12, includeMarkdown("include.Rmd"))
                     )
                   )
                   
          )
          
        )
      
    )
  )
)

