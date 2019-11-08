rm(list=ls())

library(httr)
library(XML)
library(rvest)
library(twitteR)

# Q1
search_url_blog= "https://openapi.naver.com/v1/search/blog.xml"
Client_ID = "izGsqP2exeThwwEUVU3x"
Client_Secret = "WrwbQ1l6ZI"

query = URLencode(iconv("단풍","euc-kr","UTF-8"))
url = paste(search_url_blog, "?query=", query, "&display=100", sep="")
doc = GET(url, add_headers('Content-Type' = "application/xml",
                          'X-Naver-Client-Id' = Client_ID,'X-Naver-Client-Secret' = Client_Secret))

# text preprocessing
blog_data = htmlParse(doc, encoding="UTF-8")
blog_text = xpathSApply(blog_data, "//item/description", xmlValue)
blog_text = gsub("[[:punct:][:cntrl:]quot]", "", blog_text)
blog_text = gsub("b단풍b", "단풍", blog_text)
blog_text

write.table(blog_text, "naverblog.txt")

# Q2
search_url_news= "https://openapi.naver.com/v1/search/news.xml"
Client_ID = "izGsqP2exeThwwEUVU3x"
Client_Secret = "WrwbQ1l6ZI"

query = URLencode(iconv("빅데이터","euc-kr","UTF-8"))
url = paste(search_url_news, "?query=", query, "&display=100", sep="")
doc = GET(url, add_headers('Content-Type' = "application/xml",
                          'X-Naver-Client-Id' = Client_ID,
                          'X-Naver-Client-Secret' = Client_Secret))

# text preprocessing
news_data = htmlParse(doc, encoding="UTF-8")
news_text = xpathSApply(news_data, "//item/title", xmlValue); 
news_text = gsub("[[:punct:][:cntrl:]quot]", "", news_text)
news_text = gsub("b빅데이터b", "빅데이터", news_text)
news_text = gsub("b데이터b", "데이터", news_text)
news_text

write.table(news_text, "navernews.txt")


# Q3

api_key = "gjUkHgO8bFmNobRk4g0Jas8xb"
api_secret = "loF0mtnzLhtQDFjahdRHox6wcR1fiD6Fw95DP5QCSy3rLTTP1K"
access_token = "607145164-8L5HtzopZzhjuBCgusUGKE3MHOa9P4RbmhUrM0E1"
access_token_secret = "2wn2bsCA7JIH5DZ5Ss1deS5BNLabzaX2xSpM2ZLMIqwQf"
setup_twitter_oauth(api_key,api_secret, access_token,access_token_secret)

twitter_data = "취업" %>% enc2utf8() %>% searchTwitter(n = 100) %>% twListToDF() 
twitter_text = twitter_data$text

#전처리 
twitter_text = gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", twitter_text)   
twitter_text =  twitter_text %>% trimws() %>% unique()
twitter_text

write.table(twitter_text, "twitter.txt")


# Q4

API_key  = "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No = "360"
url = paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc = xmlParse(url, encoding="UTF-8")
doc_korean = xmlRoot(doc)
bus_data = xmlToDataFrame(getNodeSet(doc_korean, "//itemList"))
# bus_data = xmlToDataFrame(getNodeSet(doc_korean, "//itemList"), stringsAsFactors = F)

cat("[360번 버스 정보]\n", "노선ID: ", as.character(bus_data$busRouteId[1]), "\n", "노선길이: ", as.character(bus_data$length[1]), "\n", 
    "기점: ", as.character(bus_data$stStationNm[1]), "\n",  "종점: ", as.character(bus_data$edStationNm[1]), "\n", "배차간격: ", as.character(bus_data$term[1]), "\n")
