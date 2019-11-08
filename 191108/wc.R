rm(list=ls())

library(KoNLP)
library(wordcloud)
library(stringr)

data = readLines("data/공구.txt", encoding="UTF-8")
data_crop = NULL

for (i in 1:length(data)){
  temp = substr(data[i], 1, 2)
  if (temp %in% c('97', '98')){
    data_crop = c(data_crop, data[i])
  }
}

data_crop = gsub("[[:digit:][:punct:]]", "", data_crop)
# str_replace_all
# 공구해주세 -> "^공구.*"

data_crop = trimws(data_crop)

useSejongDic()

noun_data = extractNoun(data_crop)
noun_data = unlist(noun_data)

windowsFonts(lett=windowsFont("휴먼옛체"))

noun_data_2_char <- Filter(function(x) {nchar(x) >= 2}, noun_data)
word_table = table(noun_data_2_char)
final <- head(sort(word_table, decreasing=T),32)[-1:-2]
final = final[c(-10,-12)]

wordcloud(names(final), freq=final,scale=c(3,0.5),rot.per=0.35,min.freq=1,
          random.order=F,random.color=T,colors=rainbow(100))

png(filename="wc.png")
wordcloud(names(final), freq=final,scale=c(3,0.5),rot.per=0.35,min.freq=1,
          random.order=F,random.color=T,colors=rainbow(100))
dev.off()
