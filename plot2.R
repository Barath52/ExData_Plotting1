q<-read.csv("household_power_consumption.txt",sep=";",col.names = c("Date","Time","GAP","GRP","Volt","GI","S1","S2","S3"))
library(dplyr)
library(lubridate)
v<-tbl_df(q)

v<-v %>% mutate_all(~na_if(.,"?")) %>% mutate_if(is.factor,as.character) %>% 
  mutate_at(c(3,4,5,6,7,8,9),as.numeric) %>% mutate_at(c(3,4,5,6,7,8,9),as.numeric) %>% 
  mutate_at(1,dmy) %>% mutate_at(2,hms) 


v<-filter(v,Date=="2007-02-01" | Date=="2007-02-02")
plot(v$GAP,xaxt="n",type="l",lwd=1.3,main="",xlab = "",ylab = "Global Active Power(kilowatts)")
axis(1,at=c(1,1440,2880),labels = c("Thu","Fri","Sat"),lwd= 1.7)
axis(2,lwd=1.7)
dev.copy(png,"plot2.png")
dev.off()


