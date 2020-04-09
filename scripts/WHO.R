require(tidyverse)
require(lubridate)

readWHO <- function(path = "./data/WHO/",
                    file = "report 1.csv",
                    date = NULL,
                    reportNumber = 1){
     rawData <- NULL
     require(tidyverse)
     require(lubridate)
     toRead <- paste(path,
                     file,
                     sep = "")
     rawData <- read_csv(file = toRead)
     rawData$report <- reportNumber
     rawData$date <- date
     rawData$New[is.na(rawData$New)] <- FALSE
     return(rawData)
}

WHOClean <- function(dataSet = WHO){
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "Federal Democratic Republic of Napal")] <-
          "Napal"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "Republic of Singapore")] <-
          "Singapore"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "the United Kingdom")] <-
        "United Kingdom"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "The United Kingdom")] <-
        "United Kingdom"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "the United States")] <-
        "United States of America"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "Saint Barthlemy")] <-
        "Saint Barthelemy"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "occupied Palestinian territory")] <-
        "Occupied Palestinian Territory"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "occupied Palestinian Territory")] <-
       "Occupied Palestinian Territory"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "Cote d?Ivoire")] <-
       "Cote d Ivoire"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "Kosovo[1]")] <-
       "Kosovo"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "Lao People?s Democratic Republic")] <-
       "Lao People's Democratic Republic"
     dataSet$`Country Territory area`[which(dataSet$`Country Territory area` == "Dominican")] <-
       "Dominican Republic"



     dataSet <- dataSet %>%
       filter(Region != "Other")



     return(dataSet)
}

endReport <- 80  # 78
WHO <- NULL
startDay <- as.Date("21-Jan-2020", format = "%d-%b-%Y")

for (i in 1:endReport) {
     reportDate <- startDay + days(i - 1)

     fileName <- paste("report ",
                       i,
                       ".csv",
                       sep = "")
     temp <- readWHO(file = fileName,
                     date = reportDate,
                     reportNumber = i)

     WHO <- rbind(WHO,
                  temp)
     rm(temp)
}

WHO <- WHOClean(dataSet = WHO)

# WHO
temp <- table(WHO$`Country Territory area`,
      useNA = "ifany")
temp[order(temp,
           decreasing = TRUE)]
temp[temp == 1]
length(temp)

table(WHO$date,
      useNA = "ifany")
length(table(WHO$date,
             useNA = "ifany"))

table(WHO$report,
      useNA = "ifany")
length(table(WHO$report,
             useNA = "ifany"))

temp <- table(WHO$Region,
      useNA = "ifany")
temp[order(temp,
           decreasing = TRUE)]
rm (temp)

tail(WHO)
