library(lubridate)
library(plyr)
library(dplyr)

RGDP <- read.table("./RGDP_CHANGE.csv", sep=",", header= TRUE)
RGDP$DATE <- ymd(RGDP$DATE)

CARTER <- RGDP[RGDP$DATE >= ymd(19790120),]
CARTER <- CARTER[CARTER$DATE <= ymd(19830201),]
CARTER <- mutate(CARTER, PRES = "39_Carter")

REAGAN <- RGDP[RGDP$DATE >= ymd(19830120),]
REAGAN <- REAGAN[REAGAN$DATE <= ymd(19890201),]
REAGAN <- mutate(REAGAN, PRES = "40_Reagan")

BUSHSR <- RGDP[RGDP$DATE >= ymd(19890120),]
BUSHSR <- BUSHSR[BUSHSR$DATE <= ymd(19930201),]
BUSHSR <- mutate(BUSHSR, PRES = "41_Bush")

CLINTON <- RGDP[RGDP$DATE >= ymd(19930120),]
CLINTON <- CLINTON[CLINTON$DATE <= ymd(20010120),]
CLINTON <- mutate(CLINTON, PRES = "42_Clinton")

BUSH <- RGDP[RGDP$DATE >= ymd(20010120),]
BUSH <- BUSH[BUSH$DATE <= ymd(20090201),]
BUSH <- mutate(BUSH, PRES = "43_Bush")

OBAMA <- RGDP[RGDP$DATE >= ymd(20090101),]
OBAMA <- OBAMA[OBAMA$DATE <= ymd(20170130),]
OBAMA <- mutate(OBAMA, PRES = "44_Obama")

RGDP_N <- rbind(CLINTON, BUSH, OBAMA)

png("RGDP.png",height=2000, width=4000,res=200)
plot(RGDP[,1:2],type="l", m="Real GDP Growth (FRED)", xlab="", ylab="%",ylim=c(-8,8),xlim=c(ymd(19890101),ymd(20170120)))
#lines(CARTER[,1:2],type="l",col="blue3",lwd=3)
#lines(REAGAN[,1:2],type="l",col="firebrick2",lwd=3)
lines(BUSHSR[,1:2],type="l",col="brown2",lwd=3)
lines(CLINTON[,1:2],type="l",col="dodgerblue3",lwd=3)
lines(OBAMA[,1:2],type="l",col="deepskyblue3",lwd=3)
lines(BUSH[,1:2],type="l",col="firebrick3",lwd=3)
library(Hmisc)
minor.tic(nx=5)
legend("topleft", legend=c("Clinton","Bush", "Obama", "Bush Sr"),col=c("dodgerblue3","firebrick3","deepskyblue3","brown2"), lty=1,lwd=2)
abline(0,0)
#temp <- as.data.frame(())
text(15500,-6.2,"Obama: 1.80% mean", col="deepskyblue3")
text(12500,-6.64,"Bush Jr: 1.66% mean", col="firebrick3")
text(10000,-4.24,"Clinton: 3.76% mean", col="dodgerblue3")
text(8000,-5.94,"Bush Sr: 2.06% mean",col="brown2")
#text(6000,-3.21,"Reagan: 4.79% mean",col="firebrick2")
#text(5000,-7.34,"Carter: 0.66% mean",col="blue3")
dev.off()
