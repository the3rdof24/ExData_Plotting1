library(sqldf)
library(dplyr)

# Read data for 2007-Feb-01 to 2007-Feb-02
powerConsumption <-
    read.csv.sql(
        "household_power_consumption.txt",
        "select * from file where [Date] IN ('1/2/2007', '2/2/2007')",
        sep = ";"
    )

# Convert Date and Time columns to one Date/Time column
powerConsumption$DateTime <- with(powerConsumption, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S", tz = ""))

# Sort by DateTime
powerConsumption <- arrange(powerConsumption, DateTime)


png(filename = "plot3.png", width = 480, height = 480)

with(powerConsumption,
     plot(
         range(DateTime),
         range(Sub_metering_1, Sub_metering_2, Sub_metering_3),
         type = "n",
         xlab = "",
         ylab = "Energy sub metering"
     ))

with(powerConsumption, points(DateTime, Sub_metering_1, type = "l", col = "black"))
with(powerConsumption, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(powerConsumption, points(DateTime, Sub_metering_3, type = "l", col = "blue"))

legend("topright", legend = paste("Sub_metering_", 1:3, sep = ""), col = c("black", "red", "blue"), lty = 1)

dev.off()
