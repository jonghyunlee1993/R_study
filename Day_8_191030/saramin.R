rm(list=ls())
library(rvest)
# getwd()
# setwd("C:/Rstudy/Day_8_191030")

url = "http://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=default_mysearch&searchword=DATA%20SCIENTIST"
html = read_html(url)
tech_name_nodes = html_nodes(html, '.swiper-slide')

tech_name = html_text(tech_name_nodes, trim = T)
tech_name = gsub("[[:punct:][:cntrl:]]", "", tech_name)
tech_name = gsub("[[:space:][:digit:]]", "", tech_name)
tech_name = gsub("삭제", "", tech_name)
tech_name = tech_name[-(length(tech_name))]

info_count = html_text(tech_name_nodes, trim = T)
info_count = gsub("[[:space:][:punct:][:cntrl:][:alpha:]]", "", info_count)
info_count = info_count[-(length(info_count))]

result = data.frame(tech_name, info_count)
write.csv(result, "saramin.csv")