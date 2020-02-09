rm(list=ls())

library(leaflet)
library(dplyr)
library(ggmap)

register_google(key='AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c')
addr = c("서귀포시 송산동 700-21")

gc <- geocode(enc2utf8(addr))

lon <- gc$lon
lat <- gc$lat

msg <- '<strong>이종현의 집</strong><hr>제주 서귀포시 천지연로 29번길 2'
# 해당 버튼을 누르면 보이게 끔
my_map <- leaflet() %>% setView(lng = lon, lat = lat, zoom = 16) %>% 
  addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='purple', popup = msg )
my_map

saveWidget(my_map, file="mymap.html")
