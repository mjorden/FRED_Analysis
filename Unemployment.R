library(lubridate)
library(plyr)
library(dplyr)

UNRATE <- read.table("./UNRATE.csv", sep=",", header= TRUE)
UNRATE$DATE <- ymd(UNRATE$DATE)

CLINTON <- UNRATE[UNRATE$DATE >= ymd(19930120),]
CLINTON <- CLINTON[CLINTON$DATE <= ymd(20010120),]
CLINTON <- mutate(CLINTON, PRES = "42_Clinton")

BUSH <- UNRATE[UNRATE$DATE >= ymd(20010120),]
BUSH <- BUSH[BUSH$DATE <= ymd(20090201),]
BUSH <- mutate(BUSH, PRES = "43_Bush")

OBAMA <- UNRATE[UNRATE$DATE >= ymd(20090101),]
OBAMA <- OBAMA[OBAMA$DATE <= ymd(20170130),]
OBAMA <- mutate(OBAMA, PRES = "44_Obama")

UNRATE_N <- rbind(CLINTON, BUSH, OBAMA)

png("UNRATE.png",height=2000, width=4000,res=200)
plot(UNRATE[,1:2],type="l", m="U5 Unemployment (FRED)", xlab="", ylab="%",ylim=c(0,10),xlim=c(ymd(19930101),ymd(20170120)))

lines(CLINTON[,1:2],type="l",col="dodgerblue3",lwd=3)
lines(OBAMA[,1:2],type="l",col="deepskyblue3",lwd=3)
lines(BUSH[,1:2],type="l",col="firebrick3",lwd=3)
legend("topleft", legend=c("Clinton","Bush", "Obama"),col=c("dodgerblue3","firebrick3","deepskyblue3"), lty=1,lwd=2)
#temp <- as.data.frame(())
text(15500,2,"Obama: 3.2% change", col="deepskyblue3")
text(12500,2,"Bush Jr: -4.1% change", col="firebrick3")
text(10000,2,"Clinton: 2.9% change", col="dodgerblue3")

dev.off()