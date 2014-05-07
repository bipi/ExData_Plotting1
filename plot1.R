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

png('plot1.png')
par(bg='transparent')
hist(epcDateAdjusted$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()