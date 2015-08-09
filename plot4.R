# Loads the Power consumption data file for 02/01/2007 to 02/02/2007
library(sqldf)
consumption<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ( '1/2/2007','2/2/2007')",header=TRUE,sep=";")
closeAllConnections()

# Create a new field datetime to from date and time fields so as to create single field with both date and time

consumption$datetime<-strptime(paste(as.Date(consumption$Date,'%d/%m/%Y'),consumption$Time),'%Y-%m-%d %H:%M:%S')

# Create a PNG device with file name as plot2.png and 480X480 pixel dimension
dev<-png(filename = "plot4.png",width = 480, height = 480)
# set paramter for a 2X2 chart filled row wise
par(mfrow=c(2,2))
# Plot a line chart for global active power row 1 column 1 , i.e xy plot with type as line 

with(consumption,plot(datetime, Global_active_power,type="l",ylab="Global Active Power (kilowatts)"))
# Plot a line chart for voltage , row 1 column 2, i.e xy plot with type as line
with(consumption,plot(datetime,Voltage,type="l",ylab="Voltage"))
# Plot a multi variable chart on row 2 column 3 for sub metering variables
with(consumption,plot(datetime, Sub_metering_1,type="l",ylab="Energy sub metering"))
points(consumption$datetime,consumption$Sub_metering_2,type ="l",col="red")
points(consumption$datetime,consumption$Sub_metering_3,type ="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
# Plot reactive power line chart of row 2 column4
with(consumption,plot(datetime, Global_reactive_power,type="l"))

# close and release the PNG device
dev.off()
# remove data set
rm(consumption)
