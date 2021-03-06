
# 특정 구의 코드를 추출하고 이 코드의 하위에 있는 동을 추출하는 방법
library(Kormaps)
data(korpopmap2)
data(korpopmap3)
Encoding(korpopmap2@data$name)<-'UTF-8'
korpopmap2@data$code.data
korpopmap2@data$name
gucodename <- korpopmap2@data[,c("name", "code.data")]

names(gucodename)
Encoding(korpopmap3@data$name)<-'UTF-8'
korpopmap3@data$code.data
korpopmap3@data$name

guname <- '강남구'
gucode <- gucodename[gucodename$name == guname, "code.data"]
pattern <- paste0('^', gucode)
korpopmap3@data[grep(pattern, korpopmap3@data$code.data), 
                c("code.data", "name")]

# 정규표현식 보충
# 숫자 표현
# \d [0123456789] [9876543210] [0-9] [:digit:]
gsub("ABC", "***", "ABCabcABC")  #ABC를 **로 변환
gsub("ABC", "***", "ABCabcABC", ignore.case=T) # 대소문자 무시
x <- c("ABCabcABC", "abcABCabc")
gsub("ABC", "***", x) # 여러개 원소에 각각 적용된다
gsub("b.n", "***", "i love banana")  
gsub("b.*n", "***", "i love banana") 
gsub("(bz)*n", "***", "i love banana") # 'bz' 'bzbz' ... 를 찾음
gsub("[bn]a", "***", "i love banana") 
# 중간에 4글자
gsub("010-[0-9]{4}-[0-9]{4}", "010-****-****", "내 폰번호는 010-1234-6789")
# 중간에 3글자 혹은 4글자
gsub("010-[0-9]{3,4}-[0-9]{4}", "010-****-****", "내 폰번호는 010-1234-6789") 
# 인용부호 안에서 사용되는 백슬래시는 2개를 써야 문자열로 인식하지 않음
gsub("010-\\d{4}-\\d{4}", "010-****-****", "내 폰번호는 010-1234-6789") 
gsub(" +", " ", "i   love    banana")
# 공구 뒤에 어떤 단어가 오던 공구로 치환
gsub("공구.*", "공구", "공구해주세요") 


# apply 계열의 함수들 / 아규먼트로 함수를 받음
# 고차함수 / 고계함수라고 부르기도 함
# 함수를 일반 데이터 값처럼 다루는 함수를 지칭
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c("M", "F", "M", "M", "F", "F")

df <- data.frame(w=weight, h=height)
df
# sum() 함수에 전달할 아규먼트는 4번째 아규먼트부터
apply(df, 1, sum, na.rm=TRUE)
apply(df, 2, sum, na.rm=TRUE)
lapply(df, sum, na.rm=TRUE)
sapply(df, sum, na.rm=TRUE)
# 범주 값에 대한 연산
tapply(df$w, gender, mean, na.rm=TRUE)
tapply(1:6, gender, sum, na.rm=TRUE)
# multiple 아규먼트에 대해서 적용 가능
# 첫번째 값만 함수를 받음
mapply(paste, 1:5, LETTERS[1:5], month.abb[1:5])
count <- 1
myf <- function(x, wt=T){
  print(paste(x,"(",count,")"))
  Sys.sleep(1)
  if(wt) 
    r <- paste("*", x, "*")
  else
    r <- paste("#", x, "#")
  count <<- count + 1;
  return(r)
}
sapply(df$w, myf)
sapply(df$w, myf, F)
sapply(df$w, myf, wt=F)
rr1 <- sapply(df$w, myf, wt=F)
str(rr1)
count <- 1
sapply(df, myf)
rr2 <- sapply(df, myf)
str(rr2)
rr2[1,1]
rr2[1,"w"]


r <- sapply(df, myf, F)
str(r)



library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(stringr)
useSejongDic()
# install.packages("tm")
library(tm)

lunch <- c("커피 파스타 치킨 샐러드 아이스크림",
           "커피 우동 소고기김밥 귤",
           "참치김밥 커피 오뎅",
           "샐러드 피자 파스타 콜라",
           "티라무슈 햄버거 콜라",
           "파스타 샐러드 커피"
)

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps)
tdm
as.matrix(tdm)

# tm 패키지는 corpus 객체를 사용함
cps <- VCorpus(VectorSource(lunch))
# TDM: 단어를 중심으로 도큐먼트의 분포 / 행: 단어, 열: 도큐먼트
# DTM: 도큐먼트를 중심으로 단어의 분포 / 행: 도큐먼트, 열: 단어
tdm <- TermDocumentMatrix(cps, 
                          control=list(wordLengths = c(1, Inf)))
tdm
(m <- as.matrix(tdm))

colnames(m) <- c("doc1", "doc2", "doc3", "doc4", "doc5", "doc6")
rowSums(m)
colSums(m)

# matrix mulitply
com <- m %*% t(m)
com # 함께 발화, 연결성, term의 상관관계
com[lower.tri(com, diag = F)] <- c(0)
com

# DTM
dtm <- DocumentTermMatrix(cps, 
                          control=list(wordLengths = c(1, Inf)))
dtm
(m2 <- as.matrix(dtm))

# DTM = t(TDM)
dtm2 = t(as.matrix(tdm))
rowSums(dtm2)
colSums(dtm2)


# install.packages("qgraph")
library(qgraph)

# log 는 표준화를 위해서
# co-ocurrence matrix에서 diagonal element는 해당 corupus에서 발화 정도
qgraph(com, labels=rownames(com), diag=F, 
       layout='spring',  edge.color='blue', 
       vsize=log(diag(com)*800))


# 문서 간의 유사도 분석
# install.packages("proxy")
library(proxy)
dd <- NULL
d1 <- c("aaa bbb ccc")
d2 <- c("aaa bbb ddd")
d3 <- c("aaa bbb ccc")
d4 <- c("xxx yyy zzz")
dd <- c(d1, d2, d3, d4)
cps <- Corpus(VectorSource(dd))
dtm <- DocumentTermMatrix(cps)
# tf-idf 생성 방법
# tf_idf <- DocumentTermMatrix(cps,
#                           control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE),
#                                          stopwords = TRUE))
as.matrix(dtm)
# 속성 확인 가능
# 현재는 term frequency로 되어 있음, 이는 자주 등장하는 단어는 중요하다고 가정
# tf-idf는 공통적으로 자주 등장하는 단어에 대해서 패널티를 부여하는 방법임
inspect(dtm)
m <- as.matrix(dtm)
com <- m %*% t(m)
com
# cosine 거리
dist(com, method = "cosine")
# Euclidean 거리
dist(com, method = "Euclidean")


# install.packages("lsa")
library(lsa)
# cosine 유사도
# 1은 동일, 0은 독립
cosine(com)

# Install
# install.packages("tm")  # 텍스트 마이닝을 위한 패키지
# install.packages("SnowballC") # 어간추출을 위한 패키지
# install.packages("wordcloud") # word-cloud generator 
# install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text <- readLines(filePath)

# VectorSource () 함수는 문자형 벡터 모음을 만듭니다.
docs <- Corpus(VectorSource(text))
# 텍스트의 특수 문자 등을 대체하기 위해 tm_map () 함수를 사용하여 변환이 수행됩니다.
# “/”,“@”및“|”을 공백으로 바꿉니다.
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
# tm_map은 gsub와 유사한 기능을 수행
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")


# 소문자로 변환
docs <- tm_map(docs, content_transformer(tolower))
# 수치 데이터 제거
docs <- tm_map(docs, removeNumbers)
# 영어 불용어 제거
# stopwords는 대부분 문법적 기능을 수행하는 단어들
# 한국어 불용어는 없음, 자체 제작한다
docs <- tm_map(docs, removeWords, stopwords("english"))

# 의미없는 단어를 제거하기 위해서 등록함
# 벡터 구조로 사용자가 직접 불용어  설정 , 제거
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 

# 문장 부호 punctuations
docs <- tm_map(docs, removePunctuation)

# 공백 제거
docs <- tm_map(docs, stripWhitespace)

# 텍스트 형태소 분석
# docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


# reshape package 실습
# install.packages("reshape2")
library(reshape2)

head(french_fries)
# time : 몇 주차 실험인가
# treatment : 사용한 식용유의 종류
# subject : 실험 대상자
# rep : 이 측정이 몇 번째 반복인가
# potato : 감자 맛
# buttery : 버터 맛
# grassy : 풀맛
# rancid : 신맛
# painty : 안 좋은 냄새

# 문제 : butter 열의 평균, grassy 열의 평균, rancid 의 평균, painty 의 평균을 구하시오.
library(reshape2)
data = as.data.frame(french_fries)
data %>% summarise(avg_potato = mean(potato, na.rm = T), 
                   avg_butter = mean(buttery, na.rm = T),
                   avg_grassy = mean(grassy, na.rm = T),
                   avg_rancid = mean(rancid, na.rm = T),
                   avg_painty = mean(painty, na.rm = T))

# melt는 열이 긴 테이블을 행이 긴 테이블로 변경 
m <- melt(french_fries, id.vars=1:4) # 첫 4행은 유지하겠다는 의미
head(m)
library(dplyr)
m %>% group_by(variable) %>% summarize(평균=mean(value, na.rm=T))
m2 <- melt(french_fries, id.vars=1:4, na.rm=T)
dim(m2)
dim(m)
m2 %>% group_by(variable) %>% summarize(평균=mean(value))

# dcast는 행으로 길게 만든 테이블을 다시 열로 길게 만드는 것을 의미함
r <- dcast(m, time + treatment + subject + rep ~ ...)
head(r)

rownames(r) <- NULL
rownames(french_fries) <- NULL

identical(r, french_fries)

# 책에 있는 예제들

str(airquality)
dim(airquality)
View(airquality)
names(airquality)

names(airquality) <- tolower(names(airquality))
head(airquality)
names(airquality)

melt_test <- melt(airquality)
dim(melt_test)
melt_test2 <- melt(airquality, id.vars=c("month", "wind"), measure.vars="ozone")
head(melt_test2)
dim(melt_test2)

melt_test3 <- melt(airquality, id.vars=c("month", "wind"))
head(melt_test3)
dim(melt_test3)

aq_melt <- melt(airquality, id.vars=c("month", "day"), na.rm=T)
dim(aq_melt)
aq_dcast <- dcast(aq_melt, month+day ~ variable)
View(airquality); 
View(aq_melt); 
View(aq_dcast); 
dcast(aq_melt, month~variable, mean)