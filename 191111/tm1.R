rm(list = ls())

library(proxy)
library(tm)

data = NULL

Duke = c('사과 포도 망고')
Dooly= c('포도 자몽 자두')
Ddochi = c('복숭아 사과 포도')
Douner = c('오렌지 바나나 복숭아')
Gildong = c('포도 바나나 망고')
Hwidong = c('포도 귤 오렌지')

data = c(Duke, Dooly, Ddochi, Douner, Gildong, Hwidong)
corpus <- Corpus(VectorSource(data))
tdm <- TermDocumentMatrix(corpus)
Encoding(tdm$dimnames$Terms) = 'EUC-KR'
as.matrix(tdm)

m <- as.matrix(tdm)
colnames(m) = c("듀크", "둘리", "또치", "도우너", "길동", "희동")

com <- m %*% t(m)
com

# 1번
distance = as.matrix(dist(t(m), method = "Euclidean"))
inds <- arrayInd(which.min(distance[distance > 0]), dim(distance))
rnames = rownames(distance)[inds[,1]]
cnames = colnames(distance)[inds[,2]]

cat(rnames, cnames)

# 2번
holder = diag(com)
holder[holder == max(diag(com))]

# 3번
holder[holder == min(diag(com))]
