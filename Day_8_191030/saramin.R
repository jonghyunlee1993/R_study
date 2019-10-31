rm(list=ls())
library(rvest)
# getwd()
# setwd("C:/Rstudy/Day_8_191030")

url = "http://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=default_mysearch&searchword=DATA%20SCIENTIST"
html = read_html(url)

tech_name_nodes = html_nodes(html, '.swiper-slide')

tech_name = html_text(tech_name_nodes, trim = T)
tech_name = gsub("[[:punct:][:cntrl:][:space:][:digit:]삭제]", "", tech_name)
tech_name = tech_name[-(length(tech_name))]

info_count = html_text(tech_name_nodes, trim = T)
info_count = gsub("[[:space:][:punct:][:cntrl:][:alpha:]]", "", info_count)
info_count = info_count[-(length(info_count))]

result = data.frame(tech_name, info_count)
write.csv(result, "saramin.csv")

# tech_name = url %>% read_html() %>% html_nodes('.swiper-slide') %>% html_text(trim = T)
# tech_name = gsub("[[:punct:][:cntrl:][:space:][:digit:]삭제]", "", tech_name)
# tech_name = tech_name[-(length(tech_name))]

# library(XML)
# 
# content = read_html(url) %>% htmlParse()
# tech_name = xpathSApply(content, '//span[@class="txt"]', xmlValue)
# tech_name = gsub("[[:punct:]]", "", tech_name)[3:length(tech_name)-1]
# 
# info_count = xpathSApply(content, '//span[@class="count"]', xmlValue)
# info_count = gsub("[^[:digit:]]", "", info_count)[3:length(info_count)]
