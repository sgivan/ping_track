#!/usr/bin/env Rscript

# script to make scatterplots of ping_track data.
data <- read.delim(file="../bin/stats.txt",stringsAsFactors=F,header=T)

to_date <- function(x) {
ldate <- strptime(x,format="%Y-%m-%dT%H:%M:%S")
ldate
}
dates <- lapply(data[1],to_date)

png(filename="Rplot%03d.png",width=1440,heigh=720)
par(lab=c(10,5,7));
# plot last hour
plot(main="Failures in Last Hour",dates[[1]][(length(dates[[1]])-30):length(dates[[1]])], data['Fail'][[1]][(length(dates[[1]])-30):length(dates[[1]])]/20, col="blue", type="p", xlab="Minutes", ylab="Failures/Attempts")
## plot last 24 hours
par(lab=c(10,5,7));
plot(main="Failures in Last 24 Hours",dates[[1]][(length(dates[[1]])-720):length(dates[[1]])],data['Fail'][[1]][(length(dates[[1]])-720):length(dates[[1]])]/20,col="blue",type="p",xlab="Hour",ylab="Failures/Attempts")
# plot last week
par(lab=c(10,5,7));
plot(main="Failures in Last Week",dates[[1]][(length(dates[[1]])-5040):length(dates[[1]])],data['Fail'][[1]][(length(dates[[1]])-5040):length(dates[[1]])]/20,col="blue",type="p",xlab="Day",ylab="Failures/Attempts")
# plot last month
par(lab=c(10,5,7));
plot(main="Failures in Last Month",dates[[1]][(length(dates[[1]])-21600):length(dates[[1]])],data['Fail'][[1]][(length(dates[[1]])-21600):length(dates[[1]])]/20,col="blue",type="p",xlab="Day",ylab="Failures/Attempts")
#dev.off()
#
# copy files to www app
#
cpfile <- function(filename) {
	print(filename)
	if (file.exists(filename)) {
		cat("'", filename, "' exists\n")	
		newfilename = paste0(destdir, filename)
		print(paste0("new file name: '", newfilename, "'"))
        if (file.exists(newfilename)) {
            file.remove(newfilename)
        }
        #rtn <- file.copy(filename,newfilename,overwrite=TRUE,copy.date=TRUE)
        rtn <- file.copy(filename,newfilename)
        print(paste0("return value: '", rtn, "'"))
	}
}
destdir <- "../www/pingTrack/displayPings/static/"
pngfiles <- c('Rplot001.png', 'Rplot002.png', 'Rplot003.png', 'Rplot004.png', 'Rplot005.png')

rtn <- lapply(pngfiles, cpfile)

