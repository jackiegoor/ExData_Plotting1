# Goal is to examine how household energy usage varies over a 2-day period in Feb 2007.
# The period used will be 2/1/2007 to 2/2/2007.
# Data is from the UC Irvine Machine Learning Repository.
# Variables in the dataset:
#       Date: in dd/mm/yyyy format
#       Time: in hh:mm:ss format
#       Global_active_power: household global minute-averaged active power (in kilowatt)
#       Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#       Voltage: minute-averaged voltage (in volt)
#       Global_intensity: household global minute-averaged current intensity (in ampere)
#       Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#               It corresponds to the kitchen, containing mainly a dishwasher, an oven and 
#               a microwave (hot plates are not electric but gas powered).
#       Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#               It corresponds to the laundry room, containing a washing-machine, a 
#               tumble-drier, a refrigerator and a light.
#       Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#               It corresponds to an electric water-heater and an air-conditioner.

# Read the data - use dplyr package so we can subset easily.
library(dplyr)

energydata <- read.csv(file="household_power_consumption.txt", sep=";", na.strings="?", header=TRUE, colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
# Filter it down to (dd/mm/yyyy) Feb 1, 2007 and Feb 2, 2007: 1/2/2007 and 2/2/2007.
energydata <- filter(energydata, Date=="1/2/2007" | Date=="2/2/2007")

z <- paste(energydata$Date, energydata$Time)
y <- strptime(z,"%d/%m/%Y %H:%M:%S")

# Plot # 2
# Set filename and size 480 x 480 pixels.
png(
        filename = "plot4.png",
        width     = 480,
        height    = 480,
        units     = "px"
)

# Plot # 4
# Set parameter to be 2 rows x 2 cols; Fill by column
par(mfcol=c(2,2))
# Plot # 2 is first
plot(y,energydata$Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)") 
lines(y, energydata$Global_active_power, pch = 3)
# Plot # 3 is second - with no border around legend.
plot(y,energydata$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering") 
lines(y, energydata$Sub_metering_1, pch = 3, col="grey")
lines(y, energydata$Sub_metering_2, pch = 3, col="red")
lines(y, energydata$Sub_metering_3, pch = 3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, lwd=2,col=c("grey","red","blue"), bty="n")
# New plot is third
plot(y,energydata$Voltage, type="n", xlab = "datetime", ylab = "Voltage") 
lines(y, energydata$Voltage, pch = 3)
# New plot is fourth
plot(y,energydata$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power") 
lines(y, energydata$Global_reactive_power, pch = 3)

dev.off()
