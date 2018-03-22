# Load the required R libraries

setwd("C:/Users/andy/project")
install.packages("devtools")

devtools::install_version("httr", version="0.6.0", repos="http://cran.us.r-project.org")

install.packages("RColorBrewer")
install.packages("tm")
install.packages("wordcloud")
install.packages('base64enc')
install.packages('ROAuth')
install.packages('stringr')
install.packages('twitteR')
install.packages("openssl")
install.packages("httpuv")
install.packages("ggplot2")
library(RColorBrewer)
library(wordcloud)
library(tm)
library(twitteR)
library(ROAuth)
library(dplyr)
library(stringr)
library(base64enc)
library("openssl")
library("httpuv")
library(ggplot2)
library(wordcloud)



download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")

api_key <- '24bX1GdLrWz4nPRFfVToEC8HV'
api_secret <- 'OjLiRyCIA0gytIjh5qvqhJKsnNHMLzyN7uC1JmHvmHZgDqwJzM'
access_token <- '935260315180249088-cMoc1FFpvE5ZFqcSN0JlDBELFqXIPG2'
access_token_secret <- '4f0Nk7tXMumLk5g4Ot5HF4uS82vvvZBcykINP7s1ow1cQ'


setup_twitter_oauth(api_key,
                    api_secret,
                    access_token,
                    access_token_secret) 

bitcoin <- searchTwitter("bitcoin", n=10000, lang=NULL, since = "2018-03-14", until = "2018-03-21")
b <- searchTwitter('bitcoin', n=100)

#function used to convert twitter lists to dataframes
df1 <- twListToDF(b)
myCorpus <- Corpus(VectorSource(df1$text))
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
myCorpus <- tm_map(myCorpus, content_transformer(removeURL))
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
myCorpus <- tm_map(myCorpus, content_transformer(removeNumPunct))
myCorpus <- tm_map(myCorpus, stripWhitespace)
myCorpusCopy <- myCorpus
myCorpus <- tm_map(myCorpus, stemDocument)
myCorpus <- Corpus(VectorSource(myCorpus))

wordFreq <- function(corpus, word) {
  results <- lapply(corpus,
                    function(x) { grep(as.character(x), pattern=paste0("\\<",word)) }
  )
  sum(unlist(results))
}
tdm <- TermDocumentMatrix(myCorpus,control = list(wordLengths = c(1, Inf)))
tdm

(freq.terms <- findFreqTerms(tdm, lowfreq = 10))


myStopwords <- c(setdiff(stopwords('english'), c("r", "big")),"and", "when", "what", "to", "this","the","that","so","of","it","is","in","at","a","be","by","for","have","on","our","are","i","will","with","you")

myCorpus <- tm_map(myCorpus, removeWords, myStopwords)
library(wordcloud)
wordcloud(myCorpus ,max.words =150,min.freq=3,scale=c(4,.5),colors=palette())

tdm <- TermDocumentMatrix(myCorpus,control = list(wordLengths = c(1, Inf)))
(freq.terms <- findFreqTerms(tdm, lowfreq = 5))


term.freq <- rowSums(as.matrix(tdm))
term.freq <- subset(term.freq, term.freq >= 4)
df2 <- data.frame(term = names(term.freq), freq = term.freq)
ggplot(df2, aes(x=term, y=freq)) + geom_bar(stat="identity") +xlab("Terms") + ylab("Count") + coord_flip() +theme(axis.text=element_text(size=7))


