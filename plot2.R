## Create A tempFile, Connect to Url and Download the Zip File(household_power_consumption.zip) to this tempFile
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

#Import only Relevant data (01 and 02 Feb 2007),identify 'NA' values),Create Datetime Column for Chart purposes.
data <- subset(read.table(unz(temp,"household_power_consumption.txt"),header = TRUE,sep = ";",na.strings = "?"), Date %in% c("1/2/2007","2/2/2007"))
unlink(temp)
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#Plot chart to png device
png(filename = "plot2.png",width = 480,height = 480, units="px")
with(data,plot(Datetime,Global_active_power,type="n",ylab = "Global Active Power (kilowatts)"))
lines(data$Datetime,data$Global_active_power,type = "l")
dev.off()