# Johns Hopskinsn Uiversity
# Data Science.Foundations using R: Exploratory Data Analysis
# Alex  M.
# OCT-NOV 2020

# Plots
# Data Source: UCI Machine Learning Repository
# Individual household electric power consumption Data Set 
# URL: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

#loading libraries
library(lubridate)

# Loading the data 
powerconsump <- read.table("./data/household_power_consumption.txt",sep=";",header=TRUE)

#Creating a timestamp variable
DataTime<-dmy_hms(paste(powerconsump$Date,powerconsump$Time))
powerconsump<-cbind(DataTime,powerconsump)

# Converting Data and Time variables format from 'char' to 'Date' and 'Time' respectively (for filtering)
powerconsump$Date<-dmy(powerconsump$Date)
powerconsump$Time<-hms(powerconsump$Time)

# Converting Char variables to numeric
powerconsump$Global_active_power<-as.numeric(powerconsump$Global_active_power)
powerconsump$Sub_metering_1<-as.numeric(powerconsump$Sub_metering_1)
powerconsump$Sub_metering_2<-as.numeric(powerconsump$Sub_metering_2)
powerconsump$Sub_metering_3<-as.numeric(powerconsump$Sub_metering_3)
powerconsump$Voltage<-as.numeric(powerconsump$Voltage)
powerconsump$Global_reactive_power<-as.numeric(powerconsump$Global_reactive_power)

#NAs manipulating
powerconsump$Global_active_power[is.na(powerconsump$Global_active_power)]<-0
powerconsump$Sub_metering_1[is.na(powerconsump$Sub_metering_1)]<-0
powerconsump$Sub_metering_2[is.na(powerconsump$Sub_metering_2)]<-0
powerconsump$Sub_metering_3[is.na(powerconsump$Sub_metering_3)]<-0
powerconsump$Voltage[is.na(powerconsump$Voltage)]<-0
powerconsump$Global_reactive_power[is.na(powerconsump$Global_reactive_power)]<-0

#Filtering by dates between  2007-02-01 and 2007-02-02
powerconsump_1FEB_2FEB_2007<-powerconsump[powerconsump$Date>="2007-02-01" & powerconsump$Date<="2007-02-02", ]

#Set up the plot window for 4 plots
par(mfrow=c(2,2))

#first plot: PLOT2
plot(powerconsump_1FEB_2FEB_2007$DataTime,powerconsump_1FEB_2FEB_2007$Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)")

#Second plot:
#data plot
Timeline<-powerconsump_1FEB_2FEB_2007$DataTime
Voltage<-powerconsump_1FEB_2FEB_2007$Voltage

scale_y<-as.numeric(seq(234,246, by=2))
plot(Timeline,Voltage,type="l",xlab="datetime",yaxt="n")
axis(2, lwd=2,at = scale_y, labels=c(234,"",238,"",242,"",246))   

#Third Plot:
#PLOT 3
#data plot
Timeline<-powerconsump_1FEB_2FEB_2007$DataTime
SubMeter1<-powerconsump_1FEB_2FEB_2007$Sub_metering_1
SubMeter2<-powerconsump_1FEB_2FEB_2007$Sub_metering_2
SubMeter3<-powerconsump_1FEB_2FEB_2007$Sub_metering_3

matplot(Timeline, cbind(SubMeter1,SubMeter2,SubMeter3),type="l",col=c("black","red","blue"),lty=c(1,1),xlab="",ylab="Energy sub metering")
axis(2,lwd=2)
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),col=c("black","red","blue"))

#Fourth PLOT
reactivePower<-powerconsump_1FEB_2FEB_2007$Global_reactive_power

scale_y<-as.numeric(seq(0,0.5, by=0.1))
plot(Timeline,reactivePower,type="h",xlab="datetime",ylab="Global_reactive_power",yaxt="n",ylim=c(0.0,0.5))
axis(2, lwd=2,at = scale_y)   

#Create the PNG file
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()
