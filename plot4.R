setwd("C:/Users/barto_000/Desktop/r/EDA/EPC")
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

png('plot4.png')
par(bg='transparent')
par(mfrow=c(2,2))
plot(epcDateAdjusted$datetime, epcDateAdjusted$Global_active_power, type='l', xlab='', ylab='Global Active Power')

plot(epcDateAdjusted$datetime, epcDateAdjusted$Voltage, type='l', xlab='datetime', ylab='Voltage')

plot(epcDateAdjusted$datetime, epcDateAdjusted$Sub_metering_1,
     type='l',
     ylab='Energy sub metering',
     xlab='')
lines(epcDateAdjusted$datetime,epcDateAdjusted$Sub_metering_2, col='red')
lines(epcDateAdjusted$datetime,epcDateAdjusted$Sub_metering_3, col='blue')
legend<-names(epcDateAdjusted[,7:9])
legend('topright',
       legend=legend,
       col=c('black','red','blue'),
       lwd=1,
       inset=c(0,0),
       bty='n')

plot(epcDateAdjusted$datetime, epcDateAdjusted$Global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power')
par(mfrow=c(1,1))

dev.off()