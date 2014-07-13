## This module reads the power consumption data and plots Global Active power vs. Time


## Download unzip and read Power consumption data (read only first 70000 lines as we don't need all the data)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
powerDat <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", nrow=70000)
unlink(temp)

## Convert Column "Date" to date class
powerDat$Date <- as.Date(powerDat$Date , "%d/%m/%Y")

## Subset Data by dates of interest
powerDat <- subset(powerDat, (Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02")) )

## Combine Date and Time into POSIXit object which is coerced to Day on plot
powerDat$Time <- strptime( paste(powerDat$Date,powerDat$Time), format="%Y-%m-%d %H:%M:%S")

## Create graph of Global Active Power vs time
png(file ="plot2.png", width=480, height=480) 
plot(x=powerDat$Time, y= as.numeric(as.vector(powerDat$Global_active_power)), xlab= "", ylab= "Global Active Power (kilowatts)", type="l")
dev.off()
