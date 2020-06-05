q<-read.csv("household_power_consumption.txt",sep=";",col.names = c("Date","Time","GAP","GRP","Volt","GI","S1","S2","S3"))
library(dplyr)
library(lubridate)
v<-tbl_df(q)

v<-v %>% mutate_all(~na_if(.,"?")) %>% mutate_if(is.factor,as.character) %>% 
   mutate_at(c(3,4,5,6,7,8,9),as.numeric) %>% mutate_at(c(3,4,5,6,7,8,9),as.numeric) %>% 
  mutate_at(1,dmy) %>% mutate_at(2,hms) 


v<-filter(v,Date=="2007-02-01" | Date=="2007-02-02")
hist(v$GAP,xlab = "Global Active Power(kilowatts)",ylab = "Frequency",col="red",main = "Global Active Power")
dev.copy(png,"plot1.png")
dev.off()

