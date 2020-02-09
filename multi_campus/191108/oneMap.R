rm(list=ls())

library(Kormaps)

# 1인 가구 정보 불러오기
DONG<-read.csv('one.csv')
colnames(DONG)<-c('구별','name','일인가구')
gangnam <- DONG %>% filter(구별=='강남구')

# 동별 단계 구분도
Encoding(names(korpopmap3))<-'UTF-8'
Encoding(korpopmap3@data$name_eng)<-'UTF-8'
Encoding(korpopmap3@data$name)<-'UTF-8'
Encoding(korpopmap3@data$행정구역별_읍면동)<-'UTF-8'
korpopmap3@data$name = gsub('·','',korpopmap3@data$name)

idx = which(korpopmap3@data$name %in% gangnam$name)[-1]

korpopmap3@data = korpopmap3@data[idx,] 
korpopmap3@data = merge(korpopmap3@data, gangnam, by.x='name', sort=FALSE)
korpopmap3@polygons<-korpopmap3@polygons[idx] 

mymap <- korpopmap3@data
mypalette <- colorNumeric(palette ='RdYlBu' , domain = mymap$'일인가구')
mypopup <- paste0(mymap$name,'<br> 1인가구: ',mymap$'일인가구')


my_map <- NULL
my_map <-leaflet(korpopmap3) %>% 
  addTiles() %>% 
  setView(lat=37.52711, lng=126.987517, zoom=12) %>%
  addPolygons(stroke =FALSE,
              smoothFactor = 0.2,
              fillOpacity = .4,
              popup = mypopup,
              color = ~mypalette(mymap$일인가구)) %>% 
  addLegend(values = ~mymap$일인가구,
             pal = mypalette,
             title = '인구수',
             opacity = 1)
my_map	

saveWidget(my_map, file="oneMap.html")
