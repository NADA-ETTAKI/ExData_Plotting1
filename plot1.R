library(sqldf)

# read only required data
data <- read.csv.sql("household_power_consumption.txt",
                     "select * from file where Date = \"1/2/2007\" or Date = \"2/2/2007\"",
                     sep=";")
data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot1.png")
hist(data$Global_active_power,
     main = "Global Active Power",
     col = "#ff2600", # pasted a screenshot from problem statement,
                      # into image editor and detected color
     xlab = "Global Active Power (kilowatts)")
dev.off()