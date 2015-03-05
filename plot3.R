library(data.table)
pcdata <- fread("./data/household_power_consumption.txt", na.strings = "?")
pcdata <- pcdata[(pcdata$Date=="1/2/2007")|(pcdata$Date=="2/2/2007"),]
pcdata$Voltage <-as.numeric(pcdata$Voltage)
pcdata$Global_active_power <-as.numeric(pcdata$Global_active_power)
pcdata$Global_reactive_power <-as.numeric(pcdata$Global_reactive_power)
pcdata$Global_intensity <-as.numeric(pcdata$Global_intensity)
pcdata$Sub_metering_1 <-as.numeric(pcdata$Sub_metering_1)
pcdata$Sub_metering_2 <-as.numeric(pcdata$Sub_metering_2)
pcdata$Sub_metering_3 <-as.numeric(pcdata$Sub_metering_3)
pcdata[ , DateTime := paste(Date, Time, sep=" ")]
pcdata$DateTime <- as.POSIXct(pcdata$DateTime, format = "%d/%m/%Y %H:%M:%S")

Sys.setlocale("LC_TIME", "English")
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  type = c("windows"))

{
y1 <- pcdata$Sub_metering_1
y2 <- pcdata$Sub_metering_2
y3 <- pcdata$Sub_metering_3
yl <- range(c(y1, y2, y3))
plot(x = pcdata$DateTime, y = y1, xlab = "", ylab = "Energy sub metering", ylim = yl, type = "l", col ="black")
par(new = TRUE)
plot(x = pcdata$DateTime, y = y2, xlab = "", ylab = "", ylim = yl, type = "l", col ="red", axes = FALSE)
par(new = TRUE)
plot(x = pcdata$DateTime, y = y3, xlab = "", ylab = "", ylim = yl, type = "l", col ="blue", axes = FALSE)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  col=c("black", "red", "blue"), lty = c(1, 1, 1))
}

dev.off()