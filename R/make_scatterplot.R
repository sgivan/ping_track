#!/usr/bin/env Rscript

# script to make scatterplots of ping_track data.
data <- read.delim(file="../bin/stats.txt",stringsAsFactors=F,header=T)
wdir <- getwd()

to_date <- function(x) {
ldate <- strptime(x,format="%Y-%m-%dT%H:%M:%S")
ldate
}
dates <- lapply(data[1],to_date)

#dates[[1]][(length(dates[[1]])-29):length(dates[[1]])]

png(filename="Rplot%03d.png",width=1440,heigh=720)
par(lab=c(10,5,7));
pnts=29
# plot last hour
#png(filename=paste0("pingTrack_",pnts,".png"),width=1440,heigh=720)
#par(lab=c(10,5,7));
plot(
     main="Failures in 2 Hours",
     dates[[1]][(length(dates[[1]])-pnts):length(dates[[1]])],
     data['Fail'][[1]][(length(dates[[1]])-pnts):length(dates[[1]])]/20,
     col="blue",
     type="p",
     xlab="Minutes",
     ylab="Failures/Attempts",
     ylim=c(0,1),
     )

# plot failures in last 4 hours 
pnts=58
#png(filename=paste0("pingTrack_",pnts,".png"),width=1440,heigh=720)
plot(
     main="Failures in 4 Hours",
     dates[[1]][(length(dates[[1]])-pnts):length(dates[[1]])],
     data['Fail'][[1]][(length(dates[[1]])-pnts):length(dates[[1]])]/20,
     col="blue",
     type="p",
     xlab="Minutes",
     ylab="Failures/Attempts",
     ylim=c(0,1),
     )
# plot failures in last 8 hours 
pnts=116
#png(filename=paste0("pingTrack_",pnts,".png"),width=1440,heigh=720)
plot(
     main="Failures in 8 Hours",
     dates[[1]][(length(dates[[1]])-pnts):length(dates[[1]])],
     data['Fail'][[1]][(length(dates[[1]])-pnts):length(dates[[1]])]/20,
     col="blue",
     type="p",
     xlab="Minutes",
     ylab="Failures/Attempts",
     ylim=c(0,1),
     )
## plot last 24 hours
pnts=720
#png(filename=paste0("pingTrack_",pnts,".png"),width=1440,heigh=720)
par(lab=c(10,5,7));
plot(
     main="Failures in Last 24 Hours",
     dates[[1]][(length(dates[[1]])-pnts):length(dates[[1]])],
     data['Fail'][[1]][(length(dates[[1]])-pnts):length(dates[[1]])]/20,
     col="blue",
     type="p",
     xlab="Hour",
     ylab="Failures/Attempts",
     ylim=c(0,1),
     )
# plot last week
pnts=5040
#png(filename=paste0("pingTrack_",pnts,".png"),width=1440,heigh=720)
par(lab=c(10,5,7));
plot(
     main="Failures in Last Week",
     dates[[1]][(length(dates[[1]])-pnts):length(dates[[1]])],
     data['Fail'][[1]][(length(dates[[1]])-pnts):length(dates[[1]])]/20,
     col="blue",
     type="p",
     xlab="Day",
     ylab="Failures/Attempts",
     ylim=c(0,1),
     )
# plot last month
pnts=21600
#png(filename=paste0("pingTrack_",pnts,".png"),width=1440,heigh=720)
par(lab=c(10,5,7));
plot(
     main="Failures in Last Month",
     dates[[1]][(length(dates[[1]])-pnts):length(dates[[1]])],
     data['Fail'][[1]][(length(dates[[1]])-pnts):length(dates[[1]])]/20,
     col="blue",
     type="p",
     xlab="Day",
     ylab="Failures/Attempts",
     ylim=c(0,1),
     )
#dev.off()
graphics.off()
#
# copy files to www app
#
cpfile <- function(filename) {
	#print(filename)
    #destdir <- "../www/pingTrack/displayPings/static/"
    destdir <- "../www/pingTrack/static/displayPings"
	if (file.exists(filename)) {
		#cat("'", filename, "' exists\n")	
		newfilename = paste0(destdir, "/", filename)
		#print(paste0("new file name: '", newfilename, "'"))
        if (file.exists(newfilename)) {
            file.remove(newfilename)
        }
        #rtn <- file.copy(filename,newfilename,overwrite=TRUE,copy.date=TRUE)
        rtn <- file.copy(filename,newfilename)
        #rtn <- file.symlink(newfilename,filename)
        #print(paste0("return value: '", rtn, "'"))
	}
}

# instead of copying files, symlink them
# /mnt/home/sgivan/projects/ping_track/www/pingTrack/static/displayPings

symlinkfile <- function(filename) {
    #print(filename)
    #destdir <- "../www/pingTrack/displayPings/static/displayPings/"
    destdir <- "../www/pingTrack/static/displayPings"
	if (file.exists(filename)) {
		#cat("'", filename, "' exists\n")	
        setwd(destdir)
        if (file.exists(filename)) {
            #file.remove(filename)
            unlink(filename)
        }
        #file.symlink(paste0("../../../../../R/",filename),filename)
        file.symlink(paste0(wdir,"/",filename),filename)
        #setwd("../../../../../R")
        setwd(wdir)
    }
}

pngfiles <- c('Rplot001.png', 'Rplot002.png', 'Rplot003.png', 'Rplot004.png')

rtn <- lapply(pngfiles, cpfile)
#rtn <- lapply(pngfiles, symlinkfile)

