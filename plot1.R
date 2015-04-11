plot1 <- function() {
        
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
        png(filename="plot1.png",
            width=480,height=480,units="px",pointsize=11,bg="white")
        
        ### Plot the data
        par(oma=c(1,1,1,1))
        par(mar=c(5.1,4.1,2,0.5))
        hist(power$Global_active_power,col="red",main="Global Active Power",
             xlab="Global Active Power (kilowatts)")
        
        ### Close connection
        dev.off()
}
