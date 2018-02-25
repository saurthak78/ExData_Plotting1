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
# histogram for the Global Active Power
#
hist(as.numeric(as.character(sub_power_cons$Global_active_power)), 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
#
# saving the plot to the device
#
dev.copy(png, 
         file = "./code and plots/plot1.png",
         width = 480,
         height = 480,
         units = "px")
#
# closing the device
#
dev.off()