file = read.table("household_power_consumption.txt", sep = ";", 
                  na.strings = "?", header = TRUE)
file$DateTime = paste(file$Date, file$Time)
file$DateTime = strptime(file$DateTime, "%d/%m/%Y %H:%M:%S")
file$Date = as.Date(file$Date, "%d/%m/%Y")

data = subset(file, Date == "2007-02-01" | Date == "2007-02-02")
data$Weekday = weekdays(data$Date, abbreviate = TRUE)
data$Hour = data$DateTime$hour
data$Minute = data$DateTime$min

png(file = "plot4.png", 480, 480)
par(mfcol = c(2, 2))

with(data, plot(DateTime, Global_active_power, type = "l",
                ylab = "Global Active Power (kilowatts)", xlab = ""))

with(data, plot(DateTime, Sub_metering_1, type = "l", col = "black", 
                ylab = "Energy sub metering", xlab = ""))
with(data, lines(DateTime, Sub_metering_2, col = "red"))
with(data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("black","red", "blue"))

with(data, plot(DateTime, Voltage, type = "l",
                ylab = "Voltage"))

with(data, plot(DateTime, Global_reactive_power, type = "l",
                ylab = "Global_reactive_power"))

dev.off()
