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

# Plot # 3
# Set filename and size 480 x 480 pixels.
png(
        filename = "plot3.png",
        width     = 480,
        height    = 480,
        units     = "px"
)

z <- paste(energydata$Date, energydata$Time)
y <- strptime(z,"%d/%m/%Y %H:%M:%S")

plot(y,energydata$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering") 
lines(y, energydata$Sub_metering_1, pch = 3, col="black")
lines(y, energydata$Sub_metering_2, pch = 3, col="red")
lines(y, energydata$Sub_metering_3, pch = 3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, lwd=2,col=c("black","red","blue"))

dev.off()
