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

# Converting Data and Time variables format from 'char' to 'Date' and 'Time' respectively
powerconsump$Date<-dmy(powerconsump$Date)
powerconsump$Time<-hms(powerconsump$Time)

# Converting Char variables to numeric
powerconsump$Global_active_power<-as.numeric(powerconsump$Global_active_power)

#NAs manipulating
powerconsump$Global_active_power[is.na(powerconsump$Global_active_power)]<-0

#Subsetting dates between  2007-02-01 and 2007-02-02
powerconsump_1FEB_2FEB_2007<-powerconsump[powerconsump$Date>="2007-02-01" & powerconsump$Date<="2007-02-02", ]

# Plot1
scale_x<-as.numeric(seq(0,6, by=2))
hist(powerconsump_1FEB_2FEB_2007$Global_active_power,main="Global Active Power",xlab="Global Active Power (Kilowatts)",col="red",xaxt="n",ylim=c(0,1200),xlim=c(0,6))
axis(1, at = scale_x)     

#Create the PNG file
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()
