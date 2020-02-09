rm(list = ls())

getwd()
setwd("C:/Users/student/Downloads")

# Q1
df = read.table("exam_product_click.log")

# Q2
df$V2 = as.factor(df$V2)
table(df$V2)

# Q3
library(dplyr)

df %>% group_by(V2) %>% count() %>% arrange(desc(n)) %>% head(1)

# Q4
df$V1 = strptime(df$V1, "%Y%m%d%H%M")
df$V3 = format(df$V1, "%H")

df %>% group_by(V3) %>% count() %>% arrange(desc(n))

# Q5
df %>% group_by(V3) %>% count() %>% arrange(desc(n)) %>% head(1)

# Q6
df$V4 = format(df$V1, "%m")
df$V1 = as.POSIXct(df$V1)
Dec_res = df %>% filter(V4 == 12) %>% group_by(V2) %>% count() %>% arrange(desc(n))
Dec_res = Dec_res[2:dim(Dec_res)[1]-1,]

# default graph
barplot(Dec_res$n, col=terrain.colors(dim(Dec_res)[1]), cex=0.8, cex.axis=0.8, 
        names.arg = Dec_res$V2, xlab = "상품ID", ylab = "클릭수", 
        main="exam1")

png(filename="exam1.png", bg="white")
barplot(Dec_res$n, col=terrain.colors(dim(Dec_res)[1]), cex=0.8, cex.axis=0.8, 
        names.arg = Dec_res$V2, xlab = "상품ID", ylab = "클릭수", 
        main="exam1")
dev.off()

# using ggplot
library(ggplot2)

ggplot(data = Dec_res, aes(x = Dec_res$V2, y = Dec_res$n)) +
  geom_bar(stat = "identity", aes(fill=rainbow(dim(Dec_res[1]))), 
           show.legend = F) +
  labs(title = "exam1", x="상품명", y="클릭수") +
  theme_light()
ggsave("exam2.png")

# Q7
library(KoNLP)

hotel = readLines("exam_hotel.txt", encoding="UTF-8")
head(hotel)

noun = unlist(extractNoun(hotel))
noun = noun[nchar(noun) >= 2]
noun_res = table(noun)

noun_res = as.data.frame(noun_res)
noun_res %>% arrange(desc(Freq)) %>% head(10)

# hotel_proc = gsub("[[:digit:][:punct:][:lower:][:upper:]]", "", hotel)
# head(hotel_proc, 30)

# noun = unlist(extractNoun(hotel_proc))
# noun = noun[nchar(noun) >= 2]
# noun_res = as.data.frame(table(noun))
# noun_res %>% arrange(Freq) %>% head(10)
