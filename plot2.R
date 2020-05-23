#download zipfile
library(dplyr)
library(datasets)
zip <- tempfile()
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, zip, method="curl")

#extract zip
txt <- unzip(zip)
unlink(zip)

#load data
data <- read.delim("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";")

#remove unused objects
rm(zip)
rm(url)
rm(txt)

#focus on project data
f_data <-
  mutate(data, mydate = as.Date(Date, "%d/%m/%Y")) %>% 
  mutate(Global_active_power = as.double(Global_active_power) ) %>% 
  mutate(Global_reactive_power = as.double(Global_reactive_power) ) %>%
  mutate(Voltage = as.double(Voltage) ) %>%
  mutate(Global_intensity = as.double(Global_intensity) ) %>%
  mutate(Sub_metering_1 = as.double(Sub_metering_1) ) %>%
  mutate(Sub_metering_2 = as.double(Sub_metering_2) ) %>%
  mutate(Sub_metering_3 = as.double(Sub_metering_3) ) 
f_data <- filter(f_data, mydate >= as.Date("01/02/2007","%d/%m/%Y") & mydate <= as.Date("02/02/2007","%d/%m/%Y"))

#remove unused objects
rm(data)

#create time series usable variable
f_data <- mutate(f_data, mydatetime = as.POSIXct(strptime(paste(f_data$Date, f_data$Time),"%d/%m/%Y %H:%M:%S")))

#create png plot
png(filename="plot2.png", width = 480, height = 480)
with(f_data, plot(as.POSIXct(mydatetime), Global_active_power/500, type="l", xlab = "", ylab = "Global active power (kilowatts)"))
dev.off()

