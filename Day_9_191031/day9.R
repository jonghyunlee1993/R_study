library(httr)
library(XML)
library(rvest)


#############  네이버 블로그 검색  #############


searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

# 'openApi_   query?'
#쿼리 문자열이나 폼 데이터가 서버로 전달될 때 W3C 규칙
#1. name = value 형식을 갖추어야 한다.
#3. 영문대소문자, 숫자, 일부 특수문자는 그대로 전달된고 그 외의 문자는 [%16진수코드값] 으로 전달된다.
#(abc~ 그대로 전달, 한글은 utf-8로 16진수 3바이트 )


#URLencode("여름추천요리")
#네이버api 형식(UTF-8)에 안맞는다 ~ euc-kr : 우리나라 고유 코드 *2바이트
#query : 검색을 원하는 문자열로서 UTF-8로 인코딩한다.
query <- URLencode(iconv("여름추천요리","euc-kr","UTF-8"))
query


url<- paste(searchUrl, "?query=", query, "&display=20", sep="")

#그냥 URL에 접속할 수 없어 _ ID/PW 값 입력하게 프로그래밍되어 있음.
#요청헤더 작성, 헤더는 프로그래밍적으로 해결 : add_hearders()함수 사용
doc<-GET(url, add_headers('Content-Type' = "application/xml",
                          'X-Naver-Client-Id' = Client_ID,'X-Naver-Client-Secret' = Client_Secret))

#파싱 방법1  xpath
doc1 <- htmlParse(doc, encoding="UTF-8")
text1<- xpathSApply(doc1, "//item/description", xmlValue)
text1


#파싱 방법2 _ rvest
doc2 <- html_nodes(read_html(doc, encoding="UTF-8"), xpath='//item/description')
text2 <- html_text(doc2)
text2

#파싱 방법3  httr _ content 함수~ 내용을 그대로 뽑아주는  
doc3 <- html_nodes(content(doc, encoding="UTF-8"), xpath='//item/description')
text3 <- html_text(doc3)
text3


###############  네이버 뉴스 검색   #################


searchUrl<- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode(iconv("검찰","euc-kr","UTF-8"))
url<- paste(searchUrl, "?query=", query, "&display=20", sep="")
doc<-GET(url, add_headers('Content-Type' = "application/xml",
                          'X-Naver-Client-Id' = Client_ID,
                          'X-Naver-Client-Secret' = Client_Secret))

paringData <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(paringData, "//item/description", xmlValue); 
text

# xmlValue : content를 추출하겠다.

#xpathSApply(paringData, "//item/title", xmlValue)
#







###########  트위터 글 읽어오기  ###########

#트위터는 완전 API제공 (함수들을 만들어서 제공 , URL등 작성필요X)

install.packages("twitteR")
library(twitteR) 
#트위터 회원가입해서 개발자로 가입하면 주는 개발자 토큰

api_key <- "gjUkHgO8bFmNobRk4g0Jas8xb"
api_secret <- "loF0mtnzLhtQDFjahdRHox6wcR1fiD6Fw95DP5QCSy3rLTTP1K"
access_token <- "607145164-8L5HtzopZzhjuBCgusUGKE3MHOa9P4RbmhUrM0E1"
access_token_secret <- "2wn2bsCA7JIH5DZ5Ss1deS5BNLabzaX2xSpM2ZLMIqwQf"
setup_twitter_oauth(api_key,api_secret, access_token,access_token_secret)

#너는 이제 우리 개발자로 인정해줄게 Rstudy 안 .httr-oauth 파일로 저장.
#이제 계속 인증할 필요X
#oauth : 클라이언트가 서버한테 인증받을 떄의 구현방식 규격화 해 놓은 것
#. 으로 시작하는 파일 : 특별한 목적에서 만들어지는 히든파일 (대부분)


# oauth 정보 저장 확인
key <- "단풍"
key <- enc2utf8(key)    


#아규먼트 : key 검색키워드 , n = 개수 
result <- searchTwitter(key, n=100)
DF <- twListToDF(result)  #리스트 데이터프레임 형식으로 변환 
str(DF)
content <- DF$text   #그중에서 text만 추출

#전처리 
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)   
content




############## 공공데이터 포탈 ###############
# '이 예시 데이터 : 실시간 버스 운영정보 , 버스 위치'

library(XML)
#XML을 지원하는 모든 API
#HTML을 지원하는 모든 API
#마크업이라는 언어라는 점에서 비슷
#HTML이 좀더 엄격해 

API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "402"


url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")


doc <- xmlParse(url, encoding="UTF-8")
#UTF-8인데도 한글이 깨진다. 공짜 API _ 우리가 추가적으로 해야되는 부분이 있을 수 있다. 


top <- xmlRoot(doc)           #트레이싱
top
#이렇게 하니까 안깨지더라. 


df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
str(df)
View(df)




busRouteId <- df$busRouteId
busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
#url이 get방식이라 크롬 브라우저에서 url쳐서 읽어올 수 있다. 


doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
View(df)
