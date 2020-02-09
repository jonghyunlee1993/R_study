rm(list=ls())

library(rvest)

url = "http://media.daum.net/ranking/popular/"
html <-read_html(url, encoding="UTF-8")

title_nodes = html_nodes(html, ".link_txt")
title = html_text(title_nodes)
title = title[seq(1,100,2)]
title = gsub("\"", "", title)

offer_nodes = html_nodes(html, ".info_news")
offer = html_text(offer_nodes)

result = data.frame(newstitle = title, newspapername = offer)
write.csv(result, "daumnews.csv")
