library(sqldf)

# read only required data
data <- read.csv.sql("household_power_consumption.txt",
                     "select * from file where Date = \"1/2/2007\" or Date = \"2/2/2007\"",
                     sep=";")
# merge Date and Time into one and convert from string
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot2.png")
plot(data$DateTime,
     data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()