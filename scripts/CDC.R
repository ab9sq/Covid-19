require(tidyverse)
require(lubridate)
cdc <- read_csv(file = "./data/CDC_data.csv")
names(cdc)[1:2] <-  c("Date",
                      "New Cases")
cdc$cum <- cumsum(cdc$`New Cases`)
cdc$Date <- as.Date(cdc$Date,
                    format = "%d-%b-%y")
cdc$`Week Number` <- epiweek(cdc$Date)

cdc$`Total Number of Cases` <- cumsum(cdc$`New Cases`)




cdcClean <- cdc %>%                                     # update with good date
     filter(Date < as.Date("2020-04-03"))
