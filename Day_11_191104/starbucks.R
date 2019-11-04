

remDr$open()
remDr$navigate('https://www.istarbucks.co.kr/store/store_map.do?disp=locale')

# 서울지역
Seoul_Click = remDr$findElement(using = 'css', '#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step1 > div.loca_step1_cont > ul > li:nth-child(1) > a')
Seoul_Click$clickElement()

# 전체클릭릭
Whole_Click = remDr$findElement(using = 'css', '#mCSB_2_container > ul > li:nth-child(1) > a')
Whole_Click$clickElement()

# 추출

count = remDr$findElements('css selector','#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step3 > div.result_num_wrap > span')  
x = sapply(count, function(x){x$getElementText()})
x = as.numeric(x)
shop = NULL
addr = NULL
phone = NULL
y1 = NULL
y2 = NULL
y3 = NULL
for(i in 1:x){
  # 매장명
  shopname = remDr$findElements('css selector',paste('#mCSB_3_container > ul > li:nth-child(',i,') > strong'))
  y1 = sapply(shopname, function(x){x$getElementText()})
  shop = c(shop,y1)
  
  # 주소 
  addrname = remDr$findElements('css selector',paste('#mCSB_3_container > ul > li:nth-child(',i,')> p'))
  y2 = sapply(addrname, function(x){x$getElementText()})
  addr = c(addr,y2)
  
  #전화번호 
  telephone = remDr$findElements('css selector',paste('#mCSB_3_container > ul > li:nth-child(',i,') > p > br'))
  y3 = sapply(telephone, function(x){x$getElementText()})
  phone = c(phone,y3)

  
  if(i%%3==0){
    remDr$executeScript(
      "var su=arguments[0]; var dom=document.querySelectorAll(
                '#mCSB_3_container > ul > li')[su]; dom.scrollIntoView();",list(i))
  }
}
shop
addr
phone
