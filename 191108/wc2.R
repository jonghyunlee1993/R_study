rm(list = ls())

library(wordcloud2)
library(KoNLP)
library(htmlwidgets) 

useSejongDic()

data = readLines("yes24.txt")
noun = unlist(extractNoun(data))
noun_2_char = Filter(function(x) {nchar(x) >= 2}, noun)
noun_table = as.data.frame(sort(table(noun_2_char), decreasing = T))

result = wordcloud2(noun_table)
saveWidget(result, "wc2.html", title="WORDCLOUD2 실습", selfcontained = F)
