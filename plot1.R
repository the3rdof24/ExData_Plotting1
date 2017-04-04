library(sqldf)

# Read data for 2007-Feb-01 to 2007-Feb-02
powerConsumption <-
    read.csv.sql(
        "household_power_consumption.txt",
        "select * from file where [Date] IN ('1/2/2007', '2/2/2007')",
        sep = ";"
    )

png(filename = "plot1.png", width = 480, height = 480)

hist(
    powerConsumption$Global_active_power,
    col = "red",
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)"
)

dev.off()
