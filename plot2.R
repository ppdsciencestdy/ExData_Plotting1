# Loads the Power consumption data file for 02/01/2007 to 02/02/2007
library(sqldf)
consumption<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ( '1/2/2007','2/2/2007')",header=TRUE,sep=";")
closeAllConnections()

# Create a new field datetime to from date and time fields so as to create single field with both date and time

consumption$datetime<-strptime(paste(as.Date(consumption$Date,'%d/%m/%Y'),consumption$Time),'%Y-%m-%d %H:%M:%S')

# Create a PNG device with file name as plot2.png and 480X480 pixel dimension
dev<-png(filename = "plot2.png",width = 480, height = 480)
# Plot a line chart , i.e xy plot with type as line
with(consumption,plot(datetime, Global_active_power,type="l",ylab="Global Active Power (kilowatts)"))
# close and release the PNG device
dev.off()
# remove data set
rm(consumption)
