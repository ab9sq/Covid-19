require(tidyverse)
require(lubridate)
cdc <- read_csv(file = "./data/CDC_data.csv")
names(cdc)[1:2] <-  c("Date",
                      "Number of new cases")
cdc$cum <- cumsum(cdc$`Number of new cases`)
cdc$Date <- as.Date(cdc$Date,
                    format = "%d-%b-%y")
cdc$`Week Number` <- week(cdc$Date)

cdcClean <- cdc %>%                                     # update with good date
     filter(Date < as.Date("2020-04-03"))
