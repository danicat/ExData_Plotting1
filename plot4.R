# Plot4.R: Produces 4 different plots based on the Electric Power Consumption data set
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
# Please make sure to replace the path accordingly to your loca
library(dplyr)
library(lubridate)

# Read data for processing
df <- read.csv("household_power_consumption.txt", as.is = TRUE, sep = ";", na.strings = "?")
tdf <- tbl_df(df)

# Prepare data filtering and mutating columns
reduced <- filter(tdf, dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02")) %>% 
           mutate(DateTime = dmy_hms(paste(Date, Time)), Global_active_power = as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power),
                  Sub1 = as.numeric(Sub_metering_1), Sub2 = as.numeric(Sub_metering_2), Sub3 = as.numeric(Sub_metering_3))

# Produces the actual plot
png("plot4.png")
par( mfrow = c(2,2) )
with(reduced, { plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
                plot(DateTime, Voltage, type = "l", ylab = "Voltage")        
                plot(DateTime, Sub1, type = "l", xlab = "", ylab = "Energy sub metering")
                lines(DateTime, Sub2, col = "red")
                lines(DateTime, Sub3, col = "blue")
                legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
                plot(DateTime, Global_reactive_power, type = "l", ylab = "Global Reactive Power")
        })
dev.off()