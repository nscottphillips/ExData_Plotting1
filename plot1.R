# Read source data
consumption <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", quote='\"')

# Fix date format
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")

# Subset by date parameters
chunk <- subset(consumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Create plot
hist(chunk$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Copy plot to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
