# Loads the Power consumption data file for 02/01/2007 to 02/02/2007
library(sqldf)
consumption<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ( '1/2/2007','2/2/2007')",header=TRUE,sep=";")
closeAllConnections()
# Create a PNG device with file name as plot2.png and 480X480 pixel dimension
dev<-png(filename = "plot1.png",width = 480, height = 480)
# Plot a histogram
with(consumption,hist(Global_active_power,xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power"))
# close and release the PNG device
dev.off()
# remove data set
rm(consumption)