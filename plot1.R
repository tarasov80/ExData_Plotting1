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
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  type = c("windows"))
hist(pcdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()