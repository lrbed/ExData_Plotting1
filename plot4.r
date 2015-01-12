raw_data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

## Filter to Intersting Data only
int_data <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(raw_data)

## consolidate data and conversion
datetime <- paste(as.Date(int_data$Date), int_data$Time)
int_data$Datetime <- as.POSIXct(datetime)

## Split area
par(mfrow=c(2,2))

## Draw plots
plot (int_data$Datetime, int_data$Global_active_power, xlab="", ylab="Global Active Power",  type="l")
plot (int_data$Datetime, int_data$Voltage, xlab="datetime", ylab="Voltage", type="l")
plot (int_data$Datetime, int_data$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
plot (int_data$Datetime, int_data$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

## copy graph to png file 
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()