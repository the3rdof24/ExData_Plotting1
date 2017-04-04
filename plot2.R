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


png(filename = "plot2.png", width = 480, height = 480)

plot(
    powerConsumption$DateTime,
    powerConsumption$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
)

dev.off()
