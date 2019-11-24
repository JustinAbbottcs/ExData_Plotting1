library(tidyverse)

##Read in data from local file, limiting rows read to preserve memory
hpc_data <- read.table("../household_power_consumption.txt", header = TRUE, sep = ";", nrows = 500000)

##Data cleaning
hpc_data <- hpc_data %>%
  mutate(Date=as.Date(hpc_data$Date, "%d/%m/%Y")) %>%
  mutate(Time=as.POSIXct(strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))) %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")

hpc_data[3:9] <- sapply(hpc_data[3:9], function(x) as.numeric(as.character(x)))

#Initializes 4 graphs and subsequently adds to each to write to pdf
png("plot4.png")
par(mfcol = c(2, 2))
with(hpc_data, {
  
  #1
  plot(y = hpc_data$Global_active_power,
       x = hpc_data$Time, 
       xlab = "",
       ylab = "Global Active Power",
       type = "l")
  #2
  with(hpc_data, plot(Time, Sub_metering_1, 
                      ylim = c(0,40), 
                      type = "l", 
                      xlab = "",
                      ylab = "Energy sub metering"))
  with(hpc_data, lines(Time, Sub_metering_2, col = "red"))
  with(hpc_data, lines(Time, Sub_metering_3, col = "blue"))
  with(hpc_data, legend("topright", 
                        col = c("black", "red", "blue"), 
                        lty = c(1, 1, 1), 
                        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")))
  #3
  plot(y = hpc_data$Voltage,
       x = hpc_data$Time, 
       xlab = "datetime",
       ylab = "Voltage",
       type = "l")
  #4
  plot(y = hpc_data$Global_reactive_power,
       x = hpc_data$Time,
       xlab = "datetime",
       ylab = "Global_reactive_power",
       type = "l")
})

#Write to and close png file
dev.off()
