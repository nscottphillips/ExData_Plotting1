# Read source data
consumption <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", quote='\"')

# Fix date format
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")

# Subset by date parameters
chunk <- subset(consumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Date and time together
datetime <- paste(as.Date(chunk$Date), chunk$Time)
chunk$datetime <- as.POSIXct(datetime)

# Create plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(chunk, {
  plot(Global_active_power ~ datetime, type="l", ylab="Global Active Power", xlab="")
  plot(Voltage ~ datetime, type="l", ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1 ~ datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ datetime,col='Red')
  lines(Sub_metering_3 ~ datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ datetime, type="l", ylab="Global_reactive_power", xlab="datetime")
})

# Copy plot to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
