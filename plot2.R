# Download the file and unzip
if (!file.exists("exdata-data-household_power_consumption.zip")) {
    url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile="exdata-data-household_power_consumption.zip")
    unzip("exdata-data-household_power_consumption.zip")
}

# Reading the data
head <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", nrows=5)
classes <- sapply(head, class)
table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=classes, na.strings="?")

# Subsetting
data <- table[table$Date %in% c("1/2/2007","2/2/2007"),]

# Converting date and time
dateTime <- paste(data$Date, data$Time, sep=' ')
dateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S",tz="")
data$Date <- dateTime
data$Time <- NULL

# Creating the png file
png("plot2.png", width = 480, height = 480)

# Plotting
with(data, plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# Closing the device
dev.off()