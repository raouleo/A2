rm(list=ls())
r<-read.csv("Rates.csv",head=T)
# install.packages("quantstrat", repos="http://R-Forge.R-project.org")
sp<-read.csv("d_SP500.csv") # note that s&p data has same range, but less observations, ie holidays
fee<-.0015
vwretd<-sp[(match(r[,1],sp[,1])),2]
c<- data.frame(r, vwretd) # only contains dates with data for both
# 1
# a
## Rule 1. Moving Average (t & L)
library(zoo)
# set up data structure. Also tried this with lists (per symbol) of variable-length lists 
# (per lag) of numeric vectors (MA's). Felt this was cleaner despite NA's.
max.period.divisor <-100 # use this to limit max L
max.L <- floor(nrow(c)/max.period.divisor)
list.MA_lt.perSymbol <-list() # a list of 3 matrices of MA_lt for each currency 
for (symbol in 2:4){
  MA_lt <- matrix(,nrow=nrow(c), ncol=max.L) # matrix is T x L
  for(l in 1:max.L){
    MA_l <- rollmean(c[,symbol], l, fill=c(NA, NA, NA)) # Moving average for all available t at lag l< L
    MA_lt[,l] <- MA_l # matrix is "triangular" depending on L & part-filled with NAs
  }
  list.MA_lt.perSymbol[[(symbol-1)]] <- MA_lt
}
