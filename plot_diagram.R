Sys.setlocale("LC_TIME", "English")

initial<-read.table("household_power_consumption.txt",nrows=100,header=TRUE,sep = ";",stringsAsFactors=FALSE)
#initial$Date<-as.Date(initial$Date,format="%d/%m/%Y")
#initial$Time<-strptime(initial$Time,format="%H:%M:%S")

classes<-sapply(initial,class)
tabAll<-read.table("household_power_consumption.txt",header=TRUE,sep = ";",stringsAsFactors=FALSE,na.strings="?",fill=TRUE,colClasses=classes)
tabAll$Date<-as.Date(tabAll$Date,format="%d/%m/%Y")
subtab<-tabAll[which(tabAll$Date=="2007-02-01"|tabAll$Date=="2007-02-02"),]
date_time<-paste(subtab$Date,subtab$Time)
date_time<-strptime(date_time, "%Y-%m-%d %H:%M:%S")
subtab2<-cbind(subtab,date_time)

#Plot1
library(datasets)
with(subtab2,hist(subtab2$Global_active_power,main="Global Active Power",xlab="Global Active Power(kilowatts)",col="red",ylim=c(0,1200)))
dev.copy(png,file="plot1.png")
dev.off()

#Plot2
with(subtab2,plot(date_time,Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)"))
dev.copy(png,file="plot2.png")
dev.off()

#Plot3
png(file = "plot3.png", width = 480, height = 480)
with(subtab2,plot(date_time,Sub_metering_1,type="l",xlab="",ylab="Enery sub metering"))
with(subtab2,lines(date_time,Sub_metering_2,col="red"))
with(subtab2,lines(date_time,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

#Plot4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(subtab2,{
	plot(date_time,Global_active_power,type="l",xlab="",ylab="Global Active Power")
	plot(date_time,Voltage,type="l",,xlab="date time",ylab="Voltage")
	plot(date_time,Sub_metering_1,type="l",xlab="",ylab="Enery sub metering")
	lines(date_time,Sub_metering_2,col="red")
	lines(date_time,Sub_metering_3,col="blue")
	legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	plot(date_time,Global_reactive_power,type="l",,xlab="date time",ylab="Global_reactive_power")
	}
)
dev.off()
