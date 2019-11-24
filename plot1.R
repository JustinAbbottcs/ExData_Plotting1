library(tidyverse)

##Read in data from local file, limiting rows read to preserve memory
hpc_data <- read.table("../household_power_consumption.txt", header = TRUE, sep = ";", nrows = 500000)

##Data cleaning
hpc_data <- hpc_data %>%
  mutate(Date=as.Date(hpc_data$Date, "%d/%m/%Y")) %>%
  mutate(Global_active_power=as.numeric(as.character(Global_active_power))) %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")

#Create histogram of cleaned data and write to png file
png("plot1.png")
hpc_hist <- hist(hpc_data$Global_active_power,
                  ylim = c(0, 1200),
                  col = "Red",
                  xlab = "Global Active Power (kilowatts)",
                  main = "Global Active Power")
dev.off()