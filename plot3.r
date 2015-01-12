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
par(mfrow=c(1,1))

## Draw plot
plot(int_data$Datetime, int_data$Sub_metering_1, xlab="", ylab="Energy Sub metering", type = "l")
lines(int_data$Datetime, int_data$Sub_metering_2, col='red')
lines(int_data$Datetime, int_data$Sub_metering_3, col='blue')
## Put legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        col=c( "black", "red", "blue"), lty="solid")
## copy graph to png file 
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()