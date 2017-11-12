#!/usr/bin/env Rscript

data <- read.csv(file="speedtest.txt", header=T, stringsAsFactors=F)

timepts <- c(4,8,12,18,24,48,72)

make_STplot <- function (x,filename="st3") {
    png(filename=paste0("pingTrack_",filename,".png"),width=1440,heigh=720)
    par(mar=c(5,5,2,5))
    with(x, plot(c(1:length(Download))*15/60,Download/1e6,ylim=range(c(Upload,Download))/1e6, type="l", col="red3", mar=c(2,5,2,5), xlab="Hours", ylab=NA))
    par(new=T)
    with(x, plot(c(1:length(Upload))*15/60,Upload/1e6,ylim=range(c(Upload,Download))/1e6, type="l", col="blue3", xlab=NA, ylab=NA, axes=F))
    mtext(side=2, line=3, "MBytes")
    par(new=T)
    with(x,plot(c(1:length(Ping)),Ping,ylim=range(Ping), type="l", col="green3", xlab=NA, ylab=NA, axes=F))
    axis(side=4)
    mtext(side=4, line=3, "Seconds")
    legend("topleft",legend=c("Download (MB)","Upload (MB)","Ping (S)"),lty=1,col=c("red3","blue3","green3"))
    legend("topright",legend=c(paste0("cor(Down v Up): ",sprintf("%.2f",cor(x$Download,x$Upload))),
                               paste0("cor(Down v Ping): ", sprintf("%.2f", cor(x$Download,x$Ping))),
                               paste0("cor(Up v Ping): ", sprintf("%.2f", cor(x$Upload,x$Ping)))
                               ))
    graphics.off()
}

for (timept in timepts) {
    if ((length(data$Ping)-(4*timept - 1)) > 0) {
        make_STplot(data[length(data$Ping):(length(data$Ping)-(4*timept - 1)),],paste0("ST",timept,"hrs"))
    }
}

