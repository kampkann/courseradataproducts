# kannan sundararaman ~ global declaration ~ developing data products project ~ coursera

# Shiny global declarations 
library(shiny)

# --------------------------------
# Reading and manipulating data in global R will be done only once when the app is loaded
# hence the performance will be better
# --------------------------------

# The tiny seasoned dataset is hosted in the git hub.
# Dataset is read from git hub 

fileurl <- 'https://raw.githubusercontent.com/kampkann/courseradataproducts/master/data/apy_dataset.csv'
#fileurl <- "apy_dataset.csv"
df.apy <- read.csv(fileurl)

# Trim function for trimming the leading / railing spaces in the state names.
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
df.apy$State <- gsub(" PRADESH", "", df.apy$State )
df.apy$State <- trim(df.apy$State)


#  Including Ranking columns 

#  Ranking for each year, each crop  - ranking the states in terms of produced  rank 1 is the highest produced

df.apy <- transform( df.apy, Staterank = ave( Produced, Year, Crop, FUN = function(x) rank(-x, ties.method="first") ) )

#  Ranking for each year, each state  - ranking the crops in terms of produced  rank 1 is the highest produced

df.apy <- transform( df.apy, Croprank = ave( Produced, Year, State, FUN = function(x) rank(-x, ties.method="first") ) )

statelist <- unique(df.apy$State)
yearlist  <- unique(df.apy$Year)
croplist  <- unique(df.apy$Crop)
croplist  <- as.character(croplist)

# -- for debugging 
# print("From global R ... ")
# print(statelist)
# print(croplist)
# print(yearlist)
# 

## global declaration ends here
