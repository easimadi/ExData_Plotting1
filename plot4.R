## Create A tempFile, Connect to Url and Download the Zip File(household_power_consumption.zip) to this tempFile
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

#Import only Relevant data (01 and 02 Feb 2007),identify 'NA' values),Create Datetime Column for Chart purposes.
data <- subset(read.table(unz(temp,"household_power_consumption.txt"),header = TRUE,sep = ";",na.strings = "?"), Date %in% c("1/2/2007","2/2/2007"))
unlink(temp)
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#Plot chart to png device
png(filename = "plot4.png",width = 480,height = 480, units="px")
par(mfrow=c(2,2))

#Global Active Power Chart
with(data,plot(Datetime,Global_active_power,type="n",ylab = "Global Active Power (kilowatts)"))
lines(data$Datetime,data$Global_active_power,type = "l")
#Voltage Chart
with(data,plot(Datetime,Voltage,type="n", ylab = "Voltage"))
lines(data$Datetime,data$Voltage,type = "l")
#SubMetering Chart
with(data, plot(Datetime,Sub_metering_1,type = "n",ylab = "Energy Sub Metering"))
lines(data$Datetime,data$Sub_metering_1,col="black")
lines(data$Datetime,data$Sub_metering_2,col="red")
lines(data$Datetime,data$Sub_metering_3,col="blue")
legend("topright", legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), col=c("black","red","blue"),lwd=1)
#Global Reactive Power chart
with(data,plot(Datetime,Global_reactive_power,type="n",ylab = "Global Reactive Power"))
lines(data$Datetime,data$Global_reactive_power,type = "l")

dev.off()