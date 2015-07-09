## Load data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  tmp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tmp)
  file <- unzip(tmp)
  unlink(tmp)
}

data <- read.table(file, sep = ";", header = T, na.strings = "?")
data$DateTime <- paste(data$Date,data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
feb <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

## Plot 2
plot2 <- function() {
  plot(feb$DateTime,feb$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
}
plot2()