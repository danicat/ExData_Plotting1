# Plot1.R: Produces a Global Active Power histogram based on the Electric Power Consumption data set
#
# By Daniela Petruzalek <daniela.petruzalek@gmail.com>
#
# Depends: dplyr, lubridate
#
# Raw data: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Notes: please be sure to have the data set uncompressed on the same dir as the R script. You can set the working
# dir with the following command:
#
# > setwd("~/Coursera/Exploratory-Data/ExData_Plotting1")
#
# Please make sure to replace the path accordingly to your local setup.

library(dplyr)
library(lubridate)

# Read data for processing
df <- read.csv("household_power_consumption.txt", as.is = TRUE, sep = ";", na.strings = "?")
tdf <- tbl_df(df)

# Prepare data filtering and mutating columns
reduced <- filter(tdf, dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02")) %>% 
           select(Date, Global_active_power) %>% 
           mutate(Date = dmy(Date), Global_active_power = as.numeric(Global_active_power))

# Produces the actual plot
png("plot1.png")
hist(reduced$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = 2)
dev.off()