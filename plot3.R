# Plot3.R: Produces a energy metering plot based on the Electric Power Consumption data set
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
           select(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
           mutate(DateTime = dmy_hms(paste(Date, Time)), Sub1 = as.numeric(Sub_metering_1), Sub2 = as.numeric(Sub_metering_2), Sub3 = as.numeric(Sub_metering_3))

# Produces the actual plot
png("plot3.png")
with(reduced, plot(DateTime, Sub1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(reduced, lines(DateTime, Sub2, col = "red"))
with(reduced, lines(DateTime, Sub3, col = "blue"))
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()