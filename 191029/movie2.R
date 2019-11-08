rm(list=ls())
setwd("C:\Rstudy\Day_7_191029")

library(rvest)

result = NULL

for (idx in 1:20){
  url_base = "https://movie.daum.net/moviedb/grade?movieId=125080&type=netizen&page="
  url = paste(url_base, idx, sep="")
  html <-read_html(url, encoding="UTF-8")
  
  star = star_parser(html, ".emph_grade")
  review = review_parser(html, ".desc_review")
  
  page = data.frame(star, review)
  result = rbind(result, page)
}

write.csv(result, "daummovie2.csv")

############

star_parser = function(html, tag){
  nodes = html_nodes(html, tag)
  result = html_text(nodes)
  
  return(result)
}

review_parser = function(html, tag){
  nodes = html_nodes(html, tag)
  result = html_text(nodes, trim=T)
  result = gsub("\t","", result)
  result = gsub("\n","", result)
  result = gsub("\r","", result)
  result = gsub("신고","", result)
  
  return(result)
}
