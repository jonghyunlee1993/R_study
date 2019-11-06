rm(list=ls())

library(dplyr)
data = read.table("product_click.log")

# Q1
# df = data$V2 %>% as.factor %>% summary %>% as.data.frame
# my_vec = df$.
# my_names= rownames(df)

res = table(data$V2)

barplot(res, col=terrain.colors(length(res)), cex=0.8, cex.axis=0.8, names.arg = names(res), xlab = "상품ID", ylab = "클릭수", main="세로바 그래프 실습")

png(filename="clicklog1.png", bg="white") # 출력을 png파일로 설정
barplot(my_vec, 
        col=terrain.colors(length(my_vec)), 
        cex=0.8, cex.axis=0.8, 
        names.arg = my_names, 
        xlab = "상품ID", 
        ylab = "클릭수", 
        main="세로바 그래프 실습")
dev.off()

# Q2
library(stringr)

time = NULL
for (time_data in data$V1){
  hour = str_sub(time_data, 9,10)
  time = c(time, hour)
}

# df2 = time %>% as.factor %>% summary %>% as.data.frame

# my_vec2 = df2$.
# my_names2 = rownames(df2)

# time2 = strptime(data$V1, "%Y%m%d%H%M")
# format(time2, "%H")


png(filename="clicklog2.png", bg="white") # 출력을 png파일로 설정
pie(res2, 
    labels=paste(names(res2), "~", as.character(as.numeric(names(res2))+1)), 
    col=rainbow(length(res2)), 
    main="파이그래프 실습")
dev.off()