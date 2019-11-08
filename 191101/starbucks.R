rm(list=ls())

library(RSelenium)

scrollTo <- function(remDr, webElem){
  remDr$executeScript("arguments[0].scrollIntoView(true);", args = list(webElem))
  webElem$highlightElement()
}

saveName = function(name, i){
  name_01 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i, ']/strong'))
  name_02 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i+1, ']/strong'))
  name_03 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i+2, ']/strong'))
  
  name = c(name_01, name_02, name_03)
  name_text = sapply(name, function(x){x$getElementText()})
  return(name_text)
}

# saveAddr = function(addr, i){
#   addr_01 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i, ']/p/text()[1]'))
#   addr_02 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i+1, ']/p/text()[1]'))
#   addr_03 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i+2, ']/p/text()[1]'))
#   
#   addr = c(addr_01, addr_02, addr_03)
#   addr_text = sapply(addr, function(x){x$getElementText()})
#   return(addr_text)
# }
# 
# saveTel = function(tel, i){
#   tel_01 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i, ']/p/text()[2]'))
#   tel_02 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i+1, ']/p/text()[2]'))
#   tel_03 = remDr$findElements(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i+2, ']/p/text()[2]'))
#   
#   //*[@id="mCSB_3_container"]/ul/li[1]/p
#   //*[@id="mCSB_3_container"]/ul/li[1]/p
#   
#   tel = c(tel_01, tel_02, tel_03)
#   tel_text = sapply(tel, function(x){x$getElementText()})
#   return(tel_text)
# }

# 위의 함수와 동일한 결과 수행
# remDr$executeScript("var su=arguments[0]: var dom=document.querySelectorAll('#mCSB_3_container > ul > li')[su]; dom.scorollIntoView():", list(i))

url = "https://www.istarbucks.co.kr/store/store_map.do?disp=locale"
remDr<-remoteDriver(remoteServerAddr= "localhost", port = 4445, browserName= "chrome")
remDr$open()
remDr$navigate(url)

Sys.sleep(2)

seoul = remDr$findElement(using='xpath', '//*[@id="container"]/div/form/fieldset/div/section/article[1]/article/article[2]/div[1]/div[2]/ul/li[1]/a')
seoul$clickElement()

Sys.sleep(1)

whole = remDr$findElement(using='xpath', '//*[@id="mCSB_2_container"]/ul/li[1]/a')
whole$clickElement()

Sys.sleep(1)

# webElem = remDr$findElement(using="xpath", '//*[@id="mCSB_3_container"]')
# remDr$executeScript("arguments[0].scrollIntoView(false);", args = list(webElem))

# 전체 리스트의 개수 확인
list_obj = remDr$findElements(using='xpath', '//*[@id="mCSB_3_container"]/ul/li')
store_num = length(list_obj)

result = NULL

store_name = NULL
# store_tell = NULL
# store_addr = NULL

for (i in seq(1, store_num, 3)){
  if (i %% 5 == 0){
    cat(i/store_num*100, "percent was done\n")  
  }
  
  webElem = remDr$findElement(using = 'xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', i, ']/strong'))
  scrollTo(remDr, webElem)
  
  Sys.sleep(1)
  
  name = saveName(name, i)
  # tel = saveTel(tel, i)
  # addr = saveAddr(addr, i)
  
  store_name = c(store_name, name)
  # store_addr = c(store_addr, addr)
  # store_tel = c(store_tel, tel)
}

# result = data.frame(store_name, store_addr, store_tel)
result = data.frame(store_name)
write.csv(result, "stabucks.csv")
# scroll_bar = remDr$findElement(using='css', '#mCSB_3_container')
# 
# item = remDr$findElements(using='xpath', '//*[@id="mCSB_3_container"]/ul/li')
# ELEMENT = remDr$findElement(using='xpath', paste0('//*[@id="mCSB_3_container"]/ul/li[', length(item), ']'))
# scroll_bar$executeScript("arguments[0].scrollIntoView(true);", ELEMENT)
# 
# scroll_bar$executeScript("elem = arguments[0]; elem.scrollIntoView(); return true;", ELEMENT)
