setwd("C:/Users/Bartek/Desktop/r/EDA - assignemt 1 - EPC/")
Sys.setlocale("LC_TIME", "English")
epc<-read.csv2('household_power_consumption.txt', nrows=100000,stringsAsFactors=F, na.strings='?')
epc$Date<-as.Date.character(epc$Date, '%d/%m/%Y')
epcDateAdjusted<-epc[epc$Date>='2007-02-01' & epc$Date<='2007-02-02',]
rm(epc)
epcDateAdjusted$Time<-as.ts(epcDateAdjusted$Time)

for (column in 3:9){
  epcDateAdjusted[,column]<-as.numeric(epcDateAdjusted[,column])
}
epcDateAdjusted$datetime<-strptime(
  paste(epcDateAdjusted$Date, epcDateAdjusted$Time, sep=' '),
  format='%Y-%m-%d %H:%M:%S')

png()
par(mfrow=c(2,2))
hist(epcDateAdjusted$Global_active_power)
plot(epcDateAdjusted$datetime, epcDateAdjusted$Global_active_power, type='l')

plot(epcDateAdjusted$datetime, epcDateAdjusted$Sub_metering_1, type='l')
lines(epcDateAdjusted$datetime, epcDateAdjusted$Sub_metering_2)
lines(epcDateAdjusted$datetime, epcDateAdjusted$Sub_metering_3)
legend<-names(epcDateAdjusted[,7:9])
legend('topright',legend=legend, lwd=1, bty='n')
par(mfrow=c(1,1))
dev.off()
