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
plot(chunk$Global_active_power ~ chunk$datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Copy plot to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

