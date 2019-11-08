url = "https://movie.naver.com/movie/point/af/list.nhn"

html <-read_html(url, encoding="CP949")

# 영화 제목 파싱
nodes = html_nodes(html, ".movie")
title = html_text(nodes)
title

# nodes = html_nodes(html, "a.movie")
# title = html_text(nodes)
# title


# review 파싱
nodes = html_nodes(html, ".title")
review = html_text(nodes, trim=T)
review = gsub("\t","", review)
review = gsub("\n","", review)
review = gsub("\r\n","", review)
review = gsub("신고","", review)
review

# 작성자 파싱
nodes = html_nodes(html, ".author")
author = html_text(nodes)
author

# 작성 시간 파싱
nodes = html_nodes(html, "td.num")
time = html_text(nodes)
time

page = data.frame(title, review)
write.csv(page, 'movie_reviews.csv')



#####################################

title_parser = function(html, tag){
  nodes = html_nodes(html, tag)
  result = html_text(nodes)
  
  return(result)
}

review_parser = function(html, tag){
  nodes = html_nodes(html, tag)
  result = html_text(nodes, trim=T)
  result = gsub("\t","", review)
  result = gsub("\n","", review)
  result = gsub("\r\n","", review)
  result = gsub("신고","", review)
  
  return(result)
}

movie_review = NULL

for (page in 1:10){
  url_base = "https://movie.naver.com/movie/point/af/list.nhn?&page="
  url = paste(url_base, page, sep="")

  html = read_html(url, encoding="CP949")

  title = title_parser(html, ".movie")
  review = review_parser(html, ".title")
  
  page = data.frame(title, review)
  movie_review = rbind(movie_review, page)
}

setwd("C:/Rstudy/Day_7_191029")
write.csv(movie_review, 'movie_reviews2.csv')
