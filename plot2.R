library(tidyverse)

##Read in data from local file, limiting rows read to preserve memory
hpc_data <- read.table("../household_power_consumption.txt", header = TRUE, sep = ";", nrows = 500000)

##Data cleaning
hpc_data <- hpc_data %>%
  mutate(Date=as.Date(hpc_data$Date, "%d/%m/%Y")) %>%
  mutate(Time=as.POSIXct(strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))) %>%
  mutate(Global_active_power=as.numeric(as.character(Global_active_power))) %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")
  
#Create line graph of cleaned data and write to png file
png("plot2.png")
hpc_line <- plot(y = hpc_data$Global_active_power,
                 x = hpc_data$Time, 
                 xlab = "",
                 ylab = "Global Active Power (kilowatts)",
                 type = "l")
dev.off()
