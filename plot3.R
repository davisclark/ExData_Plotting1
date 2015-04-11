plot3 <- function() {
        
        library(lubridate)
        fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        ### Verify data in working directory; download if missing
        if (!("household_power_consumption.txt" %in% list.files())) {
                download.file(fileUrl,"household_power_consumption.zip",
                              mode="wb")
                unzip("household_power_consumption.zip")
        }
        
        ### Read the data
        power<-read.table("household_power_consumption.txt",header=TRUE,sep=";",
                          na.strings="?",colClasses=c(
                                  "character","character","numeric","numeric",
                                  "numeric","numeric","numeric","numeric",
                                  "numeric"))
        power$Date<-dmy(power$Date)
        power<-power[((power$Date>"2007-01-31") & (power$Date<="2007-02-02")),]
        
        ### Open PNG Graphics device
        png(filename="plot3.png",
            width=480,height=480,units="px",pointsize=11,bg="white")
        
        ### Plot the data
        plot(power$Sub_metering_1,type="l",xlab="",xaxt="n", 
             ylab="Energy sub metering",cex.lab=.95)
        lines(power$Sub_metering_2,col="red")
        lines(power$Sub_metering_3,col="blue")
        axis(1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat"),las=1,cex.axis=.95)
        legend("topright",lwd=2,lty=c(1,1,1),col=c("black","red", "blue"), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        ### Close connection
        dev.off()
}