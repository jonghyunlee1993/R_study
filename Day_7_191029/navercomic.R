rm(list=ls())

library(rvest)

base_url = "https://comic.naver.com/genre/bestChallenge.nhn?&page="

results = NULL

i = 1

while (i) {
  
  if (i %% 10 == 0){
    cat("Now Crawling on Page Number:", i, "\n")
  }else if (i == 1){
    cat("Now Crawling on Page Number:", i, "\n")
  }
  
  url = paste0(base_url, i)
  html = read_html(url, encoding = "UTF-8")

  title_nodes = html_nodes(html, 'h6 > a')
  title = html_text(title_nodes, trim = T)
  title = gsub("\r\n", "", title)
  
  summary_nodes = html_nodes(html, ".summary")
  summary = html_text(summary_nodes, trim = T)
  
  star_nodes = html_nodes(html, ".rating_type > strong")
  star = html_text(star_nodes)

  page = data.frame(comicName = title, comicSummary = summary, comicGrade = star)
  results = rbind(results, page)
  
  page_num_nodes = html_nodes(html, ".page")
  page_num = html_text(page_num_nodes)
  page_num = gsub(" 현재 페이지", "", page_num)

  if (i < as.numeric(tail(page_num,1))){
    i = i + 1
  }else{
    break
  }
}

write.csv(results, "navercomic.csv")
