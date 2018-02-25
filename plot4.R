#
# Set the Working directory and read the data into R
# and create a subset of data for dates 2007-02-01, 2007-02-02.
#
library(ggplot2)
library(lattice)
library(reshape2)

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
# creating the plot4.
#
par(mfrow = c(2,2), mar = c(4,4,2,1))
#
with(sub_power_cons,{
        plot(sub_power_cons$Time, as.numeric(as.character(sub_power_cons$Global_active_power)), 
             type="l", 
             xlab="", 
             ylab="Global Active Power")
        plot(sub_power_cons$Time, as.numeric(as.character(sub_power_cons$Voltage)),
             type = "l",
             xlab = "datetime",
             ylab = "Voltage")
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
        
        legend("topright", lty=1, col=c("black","red","blue"),
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
               cex = 0.4, yjust = 0, y.intersp = 0.1, xjust = 0)
        
        plot(sub_power_cons$Time, as.numeric(as.character(sub_power_cons$Global_reactive_power)),
             type = "l", xlab = "datetime",
             ylab = "Global_reactive_power")
})

#
# saving the plot to the device
#
dev.copy(png, 
         file = "./code and plots/plot4.png",
         width = 480,
         height = 480,
         units = "px")
#
# closing the device
#
dev.off()
