library(sqldf)

# read only required data
data <- read.csv.sql("household_power_consumption.txt",
                     "select * from file where Date = \"1/2/2007\" or Date = \"2/2/2007\"",
                     sep=";")
# merge Date and Time into one and convert from string
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot4.png")

# top left
par(mfrow=c(2, 2))
plot(data$DateTime,
     data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# top right (color vector doesn't work with this type of plot)
plot(data$DateTime,
     data$Voltage,
     type="S",
     xlab = "datetime",
     ylab = "Voltage")

# bottom left
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
       lwd = 1,
       cex = 0.95, # scaling
       bty = "n") # no border

# bottom right
plot(data$DateTime,
     data$Global_reactive_power,
     type = "h",
     col = c("#2f2f2f", "#7e7e7e"),  # color cycling
     lwd = 1,
     yaxt = "n", # disables y axis rendering
     xlab = "datetime",
     ylab = "Global_reactive_power")
# adds dots
points(data$DateTime, data$Global_reactive_power, pch=".", cex=1.5)
# adds y axis
axis(side = 2,
     at = seq(0.0, 0.5, 0.1),
     gap.axis = 0.1,  # value spacing between axis labels
     cex.axis = 0.97)  # font scaling

dev.off()
