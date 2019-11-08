## Aogda 후기 읽기

library(RSelenium)
remDr<-remoteDriver(remoteServerAddr= "localhost", port = 4445, browserName= "chrome")
remDr$open()
remDr$navigate("https://www.agoda.com/ko-kr/shilla-stay-seocho/hotel/seoul-kr.html?%20cid=-204")

btn = remDr$findElement(using="xpath", '//*[@id="SearchBoxContainer"]//div[1]/a')
btn$clickElement()

# 페이지 스크롤링 다운
remDr$executeScript("scrollBy(0, 8400)")

# 스크롤 다운을 하면 해당 내용을 불러오는 코딩이 되어 있어서 스크롤 후에 파싱이 가능함
# test = NULL
# test = remDr$findElements(using = 'css', '#customer-reviews-panel > span')
# sapply(test, function(x){x$getElementText()})

more_btn = remDr$findElement(using="xpath", '//*[@id="customer-reviews-panel"]/button/div/span')
more_btn$clickElement()

final = NULL

while(T){
  reviews = remDr$findElements(using='css', 'p.Review-comment-bodyText')
  reveiws_text = sapply(reviews, function(x){x$getElementText()})
  
  final = c(final, reveiws_text)
  
  next_btn = remDr$findElement(using='xpath', '//*[@id="reviewSection"]/div[6]/div/span[3]/i')
  
  next_btn$clickElement()
  
  cat("Move to Next page\n")
  Sys.sleep(3)
}

write(unlist(final), "hotel.txt")

cat("총 ", length(final), "건의 후기가 있습니다.", sep = "")
