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

## Create multiple plots
png(file ="plot4.png", width=480, height=480) 
par(mfrow=c(2,2))

#Plot1
plot(x=powerDat$Time, y= as.numeric(as.vector(powerDat$Global_active_power)), xlab= "", ylab= "Global Active Power (kilowatts)", type="l")

#Plot2
plot(x=powerDat$Time, y= as.numeric(as.vector(powerDat$Voltage)), xlab= "datetime", ylab= "Voltage", type="l")

#Plot3
with(powerDat, plot(Time, as.numeric(as.vector(Sub_metering_1)), type="n", xlab="", ylab="Energy sub metering"))
with(powerDat, lines(Time, as.numeric(as.vector(Sub_metering_1)), col ="black"))
with(powerDat, lines(Time, as.numeric(as.vector(Sub_metering_2)), col ="red"))
with(powerDat, lines(Time, as.numeric(as.vector(Sub_metering_3)), col ="blue"))
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1,  bty="n")

#Plot4
plot(x=powerDat$Time, y= as.numeric(as.vector(powerDat$Global_reactive_power)), xlab= "datetime", ylab= "Voltage", type="l")


dev.off()