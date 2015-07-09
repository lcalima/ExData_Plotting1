## Load data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  tmp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tmp)
  file <- unzip(tmp)
  unlink(tmp)
}

## Format data
data <- read.table(file, sep = ";", header = T, na.strings = "?")
data$DateTime <- paste(data$Date,data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
feb <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

## Plot 4
plot4 <- function() {
  par(mfrow=c(2,2))
  
  ##PLOT 1
  plot(feb$DateTime,feb$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  ##PLOT 2
  plot(feb$DateTime,feb$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##PLOT 3
  plot(feb$DateTime,feb$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(feb$DateTime,feb$Sub_metering_2,col="red")
  lines(feb$DateTime,feb$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #PLOT 4
  plot(feb$DateTime,feb$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
}
plot4()