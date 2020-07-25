library(sqldf)

# read only required data
data <- read.csv.sql("household_power_consumption.txt",
                     "select * from file where Date = \"1/2/2007\" or Date = \"2/2/2007\"",
                     sep=";")
# merge Date and Time into one and convert from string
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot3.png")
plot(data$DateTime,
     data$Sub_metering_1,
     type = "s",
     xlab = "",
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type="s", col="red")
lines(data$DateTime, data$Sub_metering_3, type="s", col="blue")
legend("topright",
       legend = grep("Sub", names(data), value = TRUE),
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 1)
dev.off()