setwd("C:/Users/andy")
library(tidyr)
library(dplyr)
library(ggplot2)
a <- read_csv("USDT_BTC.csv")
b <- read_csv("USDT_DASH.csv")
c <- read_csv("USDT_ETC.csv")
d <- read_csv("USDT_ETH.csv")
e <- read_csv("USDT_LTC.csv")
f <- read_csv("USDT_XMR.csv")
g <- read_csv("USDT_XRP.csv")
h <- read_csv("USDT_ZEC.csv")

a$ticker <- c("BTC")

b$ticker <- c("DASH")

c$ticker <- c("ETC")

d$ticker <- c("ETH")

e$ticker <- c("LTC")

f$ticker <- c("XMR")

g$ticker <- c("XRP")

h$ticker <- c("ZEC")


e <- rbind(a,b,c,d,e,f,g,h)
x2 <- x[c(9,2,5,1,3,4,6,7,8)]
View(x2)

head(x2)

summary(x2)

#plot of closing prices doesn't give much info because of bitcoins huge price
close <- ggplot(x2, aes(date, close, color = ticker)) + geom_line()

data.frame(lapply(x2, function(X) X/X[10]))

