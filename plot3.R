#
# Set the Working directory and read the data into R
# and create a subset of data for dates 2007-02-01, 2007-02-02.
#
library(ggplot2)
library(lattice)

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
# creating the plot3.
#
par(mar = c(4,4,1,1))
#
plot(sub_power_cons$Time,
     sub_power_cons$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
with(sub_power_cons,lines(Time,
                          as.numeric(as.character(Sub_metering_1)),
                          col = "black"))
with(sub_power_cons,lines(Time,
                          as.numeric(as.character(Sub_metering_2)),
                          col = "red"))
with(sub_power_cons,lines(Time,
                          as.numeric(as.character(Sub_metering_3)),
                          col = "blue"))
#
# adjusting the positions of the legend box and the spacing between 
# the legend text.
#
leg <- legend("topright", lty = 1, lwd = 1.1, text.width = 0.25,
       cex = 0.75,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       plot = FALSE)
#
leftx <- leg$rect$left - 50000
rightx <- (leg$rect$left + leg$rect$w) * 1.2
topy <- leg$rect$top
bottomy <- (leg$rect$top - leg$rect$h) * 1
#
legend(x = c(leftx, rightx), y = c(topy, bottomy), lty = 1,
       lwd = 1.1, text.width = 0.25, xjust = 0.5, yjust = 1,
       col = c("black", "red", "blue"), y.intersp = 0.5,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#
# saving the plot to the device
#
dev.copy(png, 
         file = "./code and plots/plot3.png",
         width = 680,
         height = 480,
         units = "px")
#
# closing the device
#
dev.off()
