rm(list=ls())

library(RSelenium)
remDr<-remoteDriver(remoteServerAddr= "localhost", port = 4445, browserName= "chrome")
rdmDr$open()

url = "http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135"
remDr$navigate(url)

# 베스트 댓글
best_content = remDr$findElements(using="css", 'span.u_cbox_contents')
best_texts = sapply(best_content, function(x){x$getElementText()})

# 일반 댓글
# 각 페이지 별 이동

common_result = list()

more = remDr$findElements(using="css", 'a.u_cbox_select')
sapply(more, function(x){x$clickElement()})
for (i in c(1, 3:10)){
  next_xpath = paste0("//*[@id='cbox_module']/div/div[7]/div/a[", i, "]/span")
  next_page = remDr$findElement(using = 'xpath', next_xpath)
  next_page$clickElement()
  
  common_content = remDr$findElements(using="css", 'span.u_cbox_contents')
  common_texts = sapply(common_content, function(x){x$getElementText()})
  
  common_result = c(common_result, common_texts)
  
  Sys.sleep(2)
}

final_result = unlist(c(best_texts, common_result))
div = c(rep("Best", 15), rep("Common", length(final_result) - 15))
final_result = data.frame(div, final_result)
write.table(final_result, 'webtoon1.txt')
