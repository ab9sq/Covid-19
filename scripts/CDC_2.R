require(tidyverse)
require(lubridate)
cdc <- read_csv(file = "./data/CDC_data_new.csv")
names(cdc)[1:2] <-  c("Date",
                      "Total Number of Cases")
cdc$Date <- as.Date(cdc$Date,
                    format = "%d-%b-%Y")
cdc$`Week Number` <- week(cdc$Date)
cdc$`New Cases` <- 0
cdc$`New Cases`[1] <- cdc$`Total Number of cases`[1]
for(i in 2:nrow(cdc)){
     cdc$`New Cases`[i] <- cdc$`Total Number of cases`[i] -
          cdc$`Total Number of cases`[i-1]
}
