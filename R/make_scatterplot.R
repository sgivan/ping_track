#!/usr/bin/env Rscript

# script to make scatterplots of ping_track data.
data <- read.delim(file="../bin/stats.txt",stringsAsFactors=F,header=T)

to_date <- function(x) {
ldate <- strptime(x,format="%Y-%m-%dT%H:%M:%S")
ldate
}
dates <- lapply(data[1],to_date)

png(filename="Rplot%03d.png",width=1440,heigh=720)
# plot last hour
plot(main="Failures in Last Hour",dates[[1]][(length(dates[[1]])-30):length(dates[[1]])], data['Fail'][[1]][(length(dates[[1]])-30):length(dates[[1]])]/20, col="blue", type="p", xlab="Time", ylab="Failures/Attempts")
## plot last 24 hours
plot(main="Failures in Last 24 Hours",dates[[1]][(length(dates[[1]])-720):length(dates[[1]])],data['Fail'][[1]][(length(dates[[1]])-720):length(dates[[1]])]/20,col="blue",type="p",xlab="Time",ylab="Failures/Attempts")
# plot last week
plot(main="Failures in Last Week",dates[[1]][(length(dates[[1]])-5040):length(dates[[1]])],data['Fail'][[1]][(length(dates[[1]])-5040):length(dates[[1]])]/20,col="blue",type="p",xlab="Date",ylab="Failures/Attempts")
# plot last month
plot(main="Failures in Last Month",dates[[1]][(length(dates[[1]])-21600):length(dates[[1]])],data['Fail'][[1]][(length(dates[[1]])-21600):length(dates[[1]])]/20,col="blue",type="p",xlab="Time",ylab="Failures/Attempts")
#dev.off()
