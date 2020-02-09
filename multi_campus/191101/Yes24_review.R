library(RSelenium)
remDr<-remoteDriver(remoteServerAddr= "localhost", port = 4445, browserName= "chrome")
remDr$open()

url = "http://www.yes24.com/Product/goods/40936880"

remDr$navigate(url)

remDr$executeScript("scrollBy(0, 10000)")

result = NULL
end = NULL

page = 3

while(TRUE){
  more_btn = remDr$findElements(using='xpath', '//*[@id="infoset_reviewContentList"]//div[5]/a/em[1]')
  for (i in 1:length(more_btn)){
    more_btn[[i]]$clickElement()
    Sys.sleep(1)
  }
  review_data = remDr$findElements(using = 'xpath', '//*[@id="infoset_reviewContentList"]//div[3]/div[2]')
  review = sapply(review_data, function(x){x$getElementText()})
  result = c(result, review)
  
  if (page == 12){
    page = 3
  }else{
    page = page + 1
  }
  
  next_btn = remDr$findElement(using='xpath', paste0('//*[@id="infoset_reviewContentList"]/div[7]/div[1]/div/a[', i, ']'))
  next_btn$clickElement()
  
  Sys.sleep(2)
  
  # try(end = remDr$findElement(using='css', ".bgYUI next dim"), silent = T)
  # try(end = remDr$findElement(using='css', '.bgYUI next dim'))
  # if (length(end) != 0){
  #   break
  # }
}

