rm(list=ls())
r<-read.csv("Rates.csv",head=T)
sp<-read.csv("d_SP500.csv") # note that s&p data has same range, but less observations, ie holidays
fee<-.0015
vwretd<-sp[(match(r[,1],sp[,1])),2]
c<- data.frame(r, vwretd)

# 1
# a
## Rule 1. Moving Average (t & L)

MA_lt <- function(