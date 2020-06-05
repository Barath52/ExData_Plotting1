q<-read.csv("household_power_consumption.txt",sep=";",col.names = c("Date","Time","GAP","GRP","Volt","GI","S1","S2","S3"))
library(dplyr)
library(lubridate)
v<-tbl_df(q)

v<-v %>% mutate_all(~na_if(.,"?")) %>% mutate_if(is.factor,as.character) %>% 
  mutate_at(c(3,4,5,6,7,8,9),as.numeric) %>% mutate_at(c(3,4,5,6,7,8,9),as.numeric) %>% 
  mutate_at(1,dmy) %>% mutate_at(2,hms) 


v<-filter(v,Date=="2007-02-01" | Date=="2007-02-02")



par(mfrow=c(2,2))
plot(v$GAP,xaxt="n",type="l",lwd=1.3,main="",xlab = "",ylab = "Global Active Power")
axis(1,at=c(1,1440,2880),labels = c("Thu","Fri","Sat"),lwd= 1.7)
axis(2,lwd=1.7)

plot(v$Volt,xaxt="n",type="l",lwd=1.3,main="",xlab = "datetime",ylab = "Voltage")
axis(1,at=c(1,1440,2880),labels = c("Thu","Fri","Sat"),lwd= 1.7)
axis(2,lwd=1.7)

plot(v$S1,xaxt="n",type = "l",main="",xlab="",ylab="Energy sub metering")
points(v$S2,type="l",col="red",)
points(v$S3,type="l",col="blue")
axis(1,at=c(1,1440,2880),labels = c("Thu","Fri","Sat"))
legend("topright",pch = c("_","_","_"),col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "0",
       box.lwd = "0",inset =0.02 ,cex=.8)



plot(v$GRP,xaxt="n",type="l",lwd=1.3,main="",xlab = "datetime",ylab = "global_reactive_power")
axis(1,at=c(1,1440,2880),labels = c("Thu","Fri","Sat"),lwd= 1.7)
axis(2,lwd=1.7)

dev.copy(png,"plot4.png")
dev.off()


