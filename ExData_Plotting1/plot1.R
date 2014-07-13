## This module reads the power consumption data and plots a histogram for Global Active power on 02/01/2007 
## and 02/02/2007


## Download unzip and read Power consumption data (read only first 70000 lines as we don't need all the data)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
powerDat <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", nrow=70000)
unlink(temp)

## Convert Column "Date" to date class
powerDat$Date <- as.Date(powerDat$Date , "%d/%m/%Y")

## Subset Data by dates of interest
powerDat <- subset(powerDat, (Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02")) )

## Create historgram of Global Active Power from subset data
png(file ="plot2.png", width=480, height=480) 
hist(as.numeric(as.vector(powerDat$Global_active_power)), col ="red", xlab= "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

