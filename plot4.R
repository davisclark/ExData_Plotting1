plot4 <- function() {
        
        library(lubridate)
        
        ### Read the data
        if (!("household_power_consumption.txt" %in% list.files())) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                              "household_power_consumption.zip", mode="wb")
                unzip("household_power_consumption.zip")
        }
        
        power<-read.table("household_power_consumption.txt", 
                          header=TRUE,sep=";",na.strings="?", 
                          colClasses=c("character","character","numeric",
                                       "numeric","numeric","numeric",
                                       "numeric","numeric","numeric"))
        power$Date<-dmy(power$Date)
        power<-power[((power$Date>"2007-01-31") & 
                              (power$Date<="2007-02-02")),]
        
        ### Open PNG Graphics device
        png(filename = "plot4.png",
            width = 480, height = 480, units = "px", pointsize = 10,
            bg = "white")
        
        ### Prepare plot matrix
        par(mfcol=c(2,2), mar=c(4.5,4.5,4.5,1.5), oma=c(1.5,2,1,1), tck=-0.03)

        ### Plot the data (#1)
        plot(power$Global_active_power,type="l", xlab="", xaxt="n", 
             ylab="Global Active Power", cex.lab=1.1)
        axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"), las=1, 
             cex.axis=1.1)
                
        ### Plot the data (#2)
        plot(power$Sub_metering_1,type="l", xlab="", xaxt="n", 
             ylab="Energy sub metering", cex.lab=1.1)
        lines(power$Sub_metering_2, col="red")
        lines(power$Sub_metering_3, col="blue")
        axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"), las=1,
             cex.axis=1.1)
        legend("topright", lwd=2, lty=c(1,1,1), col=c("black","red", "blue"), 
               legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
               bty="n")
        
        ### Plot the data (#3)
        plot(power$Voltage,type="l", xlab="", xaxt="n", ylab="Voltage",
             cex.lab=1.1)
        axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"), las=1,
             cex.axis=1.1)
        mtext("datetime", side=1, line=2.5, cex=0.85, font=1)
        
        ### Plot the data (#4)
        plot(power$Global_reactive_power, type="l", xlab="", xaxt="n",
             ylab="Global_reactive_power", cex.lab=1.1)
        axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"), las=1,
             cex.axis=1.1)
        mtext("datetime", side=1, line=2.5, cex=0.85, font=1)
        
        ### Close connection
        dev.off()
}