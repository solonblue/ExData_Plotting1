file = read.table("household_power_consumption.txt", sep = ";", 
                  na.strings = "?", header = TRUE)
file$DateTime = paste(file$Date, file$Time)
file$DateTime = strptime(file$DateTime, "%d/%m/%Y %H:%M:%S")
file$Date = as.Date(file$Date, "%d/%m/%Y")

data = subset(file, Date == "2007-02-01" | Date == "2007-02-02")
data$Weekday = weekdays(data$Date)
data$Hour = data$DateTime$hour
data$Minute = data$DateTime$min

png(file = "plot1.png", 480, 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()