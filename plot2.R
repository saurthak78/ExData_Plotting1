#
# Set the Working directory and read the data into R
# and create a subset of data for dates 2007-02-01, 2007-02-02.
#
setwd("E:/R/coursera/Assignments/Exploratory Data Analysis")
#
power_cons <- read.table("./data/household_power_consumption.txt",
                         sep = ";",
                         header = TRUE)
#
sub_power_cons <- subset(power_cons,
                         power_cons$Date %in% c("1/2/2007","2/2/2007"))
#
# format the date and time to date and time class. 
#
sub_power_cons$Date <- as.Date(sub_power_cons$Date, "%d/%m/%Y")
sub_power_cons$Time <- strptime(sub_power_cons$Time,"%H:%M:%S")
sub_power_cons[1:1440,"Time"] <- format(sub_power_cons[1:1440,"Time"],
                                        "2007-02-01 %H:%M:%S")
sub_power_cons[1441:2880,"Time"] <- format(sub_power_cons[1441:2880,"Time"],
                                        "2007-02-02 %H:%M:%S")
#
# creating the plot2.
#
plot(sub_power_cons$Time,
     as.numeric(as.character(sub_power_cons$Global_active_power)),
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
#
title(main = "Global Active Power vs Time")
#
#
# saving the plot to the device
#
dev.copy(png, 
         file = "./code and plots/plot2.png",
         width = 480,
         height = 480,
         units = "px")
#
# closing the device
#
dev.off()

