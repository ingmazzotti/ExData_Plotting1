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
                   sep = ";",na.strings = "?",stringsAsFactors = FALSE)

#remove unused objects
rm(zip)
rm(url)
rm(txt)

#focus on project data
f_data <- mutate(data, Date = as.Date(Date, "%d/%m/%Y")) %>% 
  mutate(Global_active_power = as.double(Global_active_power) ) %>% 
  mutate(Global_reactive_power = as.double(Global_reactive_power) ) %>%
  mutate(Voltage = as.double(Voltage) ) %>%
  mutate(Global_intensity = as.double(Global_intensity) ) %>%
  mutate(Sub_metering_1 = as.double(Sub_metering_1) ) %>%
  mutate(Sub_metering_2 = as.double(Sub_metering_2) ) %>%
  mutate(Sub_metering_3 = as.double(Sub_metering_3) ) 
f_data <- filter(f_data, Date >= as.Date("01/02/2007","%d/%m/%Y") & Date <= as.Date("02/02/2007","%d/%m/%Y"))

#remove unused objects
rm(data)

#create png plot
png(filename="plot1.png", width = 480, height = 480)
hist(f_data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)")
dev.off()


