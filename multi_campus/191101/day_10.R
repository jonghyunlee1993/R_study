# install.packages("RSelenium")
library(RSelenium)

# localhost는 나의 pc를 의미함
remDr<-remoteDriver(remoteServerAddr= "localhost", port = 4445, browserName= "chrome")

# url = "http://www.yes24.com/Product/goods/40936880"

# 브라우저 구동 및 특정 페이지 이동
remDr$open()
remDr$navigate("http://www.google.com/ncr")

webElem = remDr$findElement(using = "css", "[name = 'q']")
# webElem$getElementTagName()
# str(webElem)
webElem$clearElement() # 해당 필드 초기화
webElem$sendKeysToElement(list("JAVA", key = "enter"))

# element를 매 호출 시 다시 받아와야하는 듯 함
webElem = remDr$findElement(using = "css", "[name = 'q']")
webElem$sendKeysToElement(list("R selenium pdf", key = "enter"))

webElem = remDr$findElement(using = "css", "[id = 'hpcanvas']")
webElem$clickElement()

# remDr$findElement(using = )

webElem = remDr$findElement(using = "css", '[class = "gb_e"]')
webElem$clickElement()

remDr$navigate("http://www.naver.com")
webElem = remDr$findElement(using = "css", "[id = 'query']")
webElem$sendKeysToElement(list("Python", key = "enter"))

url = "http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135"
remDr$navigate(url)
more = remDr$findElements(using="css", 'span.u_cbox_in_view_comment')
# sapply(more, function(x){x$clickElement()})
more$clickElement()

more = remDr$findElements(using="css", 'a.u_cbox_select')
sapply(more, function(x){x$clickElement()})

more = remDr$findElements(using="css", '[class = "u_cbox_select"]')
sapply(more, function(x){x$clickElement()})

# 2 page 
page = remDr$findElements(using="css", 'a.u_cbox_page')
page[[1]]$clickElement()

# 3 page
page = remDr$findElements(using="css", 'a.u_cbox_page')
page[[2]]$clickElement()

# 4 page
page = remDr$findElements(using="css", 'a.u_cbox_page')
page[[3]]$clickElement()


remDr$navigate(url)
more = remDr$findElements(using="css", 'a.u_cbox_select')
sapply(more, function(x){x$clickElement()})
for (i in 4:12){
  next_css = paste0("#cbox_module > div > div.u_cbox_paginate > div > a:nth-child(", i, ") > span")
  next_page = remDr$findElement(using = 'css', next_css)
  next_page$clickElement()
  Sys.sleep(3)
}

remDr$navigate(url)
more = remDr$findElements(using="css", 'a.u_cbox_select')
sapply(more, function(x){x$clickElement()})
for (i in 1:10){
  next_xpath = paste0("//*[@id='cbox_module']/div/div[7]/div/a[", i, "]/span")
  next_page = remDr$findElement(using = 'xpath', next_xpath)
  next_page$clickElement()
  Sys.sleep(3)
}

# 베스트 댓글 내용 읽어오기
url = "http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135"
remDr$navigate(url)

content = remDr$findElements(using="css", 'span.u_cbox_contents')
# simple apply : 간단한 데이터 형식으로 리턴하는 함수
# list apply : 리스트 형식으로 리턴
texts = sapply(content, function(x){x$getElementText()})
print(texts)

# 일반 댓글 내용 읽어오기
more = remDr$findElements(using="css", 'a.u_cbox_select')
sapply(more, function(x){x$clickElement()})
content = remDr$findElements(using="css", 'span.u_cbox_contents')
texts = sapply(content, function(x){x$getElementText()})
print(texts)


## Aogda 후기 읽기

library(RSelenium)
remDr<-remoteDriver(remoteServerAddr= "localhost", port = 4445, browserName= "chrome")
remDr$open()
remDr$navigate("https://www.agoda.com/ko-kr/shilla-stay-seocho/hotel/seoul-kr.html?%20cid=-204")

btn = remDr$findElement(using="xpath", '//*[@id="SearchBoxContainer"]//div[1]/a')
btn$clickElement()

# 페이지 스크롤링 다운
# webElem <- remDr$findElement("css", "body")
# webElem$sendKeysToElement(list(key = "end"))

# js 방식 이용
remDr$executeScript("scrollBy(0, 8400)")

# 스크롤 다운을 하면 해당 내용을 불러오는 코딩이 되어 있어서 스크롤 후에 파싱이 가능함
test = NULL
test = remDr$findElements(using = 'css', '#customer-reviews-panel > span')
sapply(test, function(x){x$getElementText()})

more_btn = remDr$findElement(using="xpath", '//*[@id="customer-reviews-panel"]/button/div/span')
more_btn$clickElement()

final = NULL

while(T){
  reviews = remDr$findElements(using='css', 'p.Review-comment-bodyText')
  reveiws_text = sapply(reviews, function(x){x$getElementText()})
  
  final = c(final, reveiws_text)

  next_btn = remDr$findElement(using='xpath', '//*[@id="reviewSection"]/div[6]/div/span[3]/i')

  if (remDr$findElement(using='css', 'span.Review-paginator-arrow.Review-paginator-arrow--inactive')) break

  next_btn$clickElement()
  
  cat("Move to Next page\n")
  Sys.sleep(3)
}

write(unlist(final), "hotel.txt")
length(final)

# yes24
url = "http://www.yes24.com/Product/goods/40936880"
remDr$navigate(url)

# scroll down
webElem <- remDr$findElement("css", "body")
webElem$sendKeysToElement(list(key = "end"))
