rm(list= ls())

# Q1
name = c("우리집")
addr = c("서귀포시 송산동 700-21")

gc <- geocode(enc2utf8(addr))
df <- data.frame(name=name,
                 lon=gc$lon,
                 lat=gc$lat)
cen <- c(df$lon,df$lat)

sec = as.POSIXlt(Sys.time())$sec

if (sec < 14){
  map_type = "terrain"
}else if (sec < 29){
  map_type = "satellite"
}else if (sec < 44){
  map_type = "roadmap"
}else if (sec < 59){
  map_type = "hybrid"
}

# get_map 은 마커 정보를 읽을 수 없음
map <- get_googlemap(center=cen,
                     maptype = map_type,
                     zoom=17,
                     size=c(640,640),
                     marker=gc)
ggmap(map) + 
  labs(title="이종현 동네", x="경도", y="위도")

ggsave("mymap.png")
