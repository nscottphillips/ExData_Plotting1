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
with(chunk,
{
  plot(Sub_metering_1 ~ datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ datetime, col='Red')
  lines(Sub_metering_3 ~ datetime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy plot to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
