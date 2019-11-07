
library(ggplot2)

# 빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()
# 선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()
# 상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

temp = ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

library(MASS)
str(Cars93)
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(shape=21, size=6)

ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(shape=21, size=6, colour="blue")

ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(shape=21, size=6, fill="blue")   

ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(colour="grey", shape=21, size=6) 


# fill 인자를 geom_point에 주는 것과 ggplot에 주는 것의 결과는 동일함
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Price)) + 
  geom_point(colour="grey", shape=21, size=6) 

ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(colour="grey", shape=21, size=6, aes(fill=Price)) 

ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +  
  geom_point(colour="grey", shape=21, size=6)

ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Oranges") # Oranges  

ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Reds") # Reds

ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Blues") # Blues


w <- data.frame(year=c("2014", "2015", "2016", "2017", "2018"), weight=c(65,66,64,68,72))
ggplot(data=w, aes(x=year)) + geom_bar()
ggplot(data=w, aes(x=year, y=weight)) + geom_bar() # 갯수를 세서 막대를 그리는게 기본이라..

# geom_bar는 기본적으로 원소의 개수를 리턴하기 때문에 만약 해당 값 자체를 
# y값으로 사용하려면 geom_bar(stat="identity")를 주어야 함
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(stat="identity")

ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(stat="identity") + 
  coord_cartesian(ylim=c(60, 75))

ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), stat="identity") + 
  coord_cartesian(ylim=c(60, 75))

ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), colour="blue", stat="identity") +
  coord_cartesian(ylim=c(60, 75))

ggplot(data=w, aes(x=year, y=weight)) +
  geom_bar(aes(fill=year), stat="identity") + 
  geom_label(aes(label=weight), nudge_y=1.1) + 
  coord_cartesian(ylim=c(60, 75))

ggplot(data=w, aes(x=year, y=weight)) +
  geom_bar(aes(fill=year), stat="identity") + 
  geom_label(aes(label=weight), nudge_y=1.3) + 
  coord_cartesian(ylim=c(60, 75))

# ggplot(data=w, aes(x=year, y=weight)) + 
#   geom_bar(aes(fill=year), stat="identity") + 
#   geom_label(aes(label=year), nudge_y=1.1, nudge_x=0) + 
#   coord_cartesian(ylim=c(60, 75))

ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), stat="identity") + 
  geom_label(aes(label=weight), nudge_y=1.1) + 
  coord_cartesian(ylim=c(60, 75)) + 
  labs(title = "테스트", subtitle="ggplot2 패키지를 이용한 시각화", x="년도", y="무게")

# 트리맵 라이브러리 설치
install.packages("treemap")
# 트리맵 메모리 로드
library(treemap)

sales_df <- read.xlsx("data.xlsx", 2, encoding="UTF-8")
# 트리맵 그리기
# index에 표현하고 싶은 계층 순서대로 벡터로 생성. product, region 순으로 벡터를 지정함으로써 product가 region보다 더 상위로 구분이 됨
treemap(sales_df, vSize="saleAmt", index=c("product", "region"), title="A기업 판매현황")

# 트리맵 그리기
treemap(sales_df, vSize="saleAmt", index=c("region", "product"), title="A기업 판매현황")

# 인터랙티브 그래프 만들기
# 패키지 준비하기
install.packages("plotly")
library(plotly)
# ggplot으로 그래프 만들기
library(ggplot2)
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()
p
# 인터랙티브 그래프 만들기
ggplotly(p)


# 인터랙티브 막대 그래프 만들기
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge")
ggplotly(p)

# --------------------------------------

# 지도 시각화
# install.packages("ggmap")
library(ggmap)
register_google(key='AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c')

lon <- 127.0147559
lat <- 37.5431424
cen <- c(lon,lat)
mk <- data.frame(lon=lon, lat=lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=mk)
ggmap(map)
map <- get_googlemap(center=cen, maptype="satellite",zoom=14, marker=mk)
ggmap(map)
map <- get_googlemap(center=cen, maptype="terrain",zoom=8, marker=mk)
ggmap(map)
map <- get_googlemap(center=cen, maptype="hybrid",zoom=14, marker=mk)
ggmap(map)+labs(title="테스트임", x="경도", y="위도")

# get_map은 지도 제공자 3개에서 끌어온다 / 융통성 높음
map <- get_map(center=cen, maptype="terrain-labels",zoom=8, marker=mk)
ggmap(map)
map <- get_map(center=cen, maptype="toner-hybrid",zoom=8, marker=mk)
ggmap(map)
map <- get_map(center=cen, maptype="watercolor",zoom=8, marker=mk)
ggmap(map)



mk <- geocode("seoul", source = "google")
print(mk)
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=mk)
ggmap(map)
mk <- geocode(enc2utf8("부산"), source = "google")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=mk)
ggmap(map)
학원lonlat <- geocode(enc2utf8("강남구 역삼동 테헤란로 212"), source = "google")
mk <- 학원lonlat
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=19)
ggmap(map) + 
  geom_point(aes(x=mk$lon, y=mk$lat), alpha=0.4, size=5, color="pink") +
  geom_text(aes(x=mk$lon, y=mk$lat, label="우리가 공부하는 곳", vjust=0, hjust=0))


# 제주도

names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도","우리집")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125",
          "서귀포시 송산동 700-21")

home_name = c("우리집")
home_addr = c("서귀포시 일주동로 8586")

gc <- geocode(enc2utf8(addr))
gc

df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=10,
                     size=c(640,640),
                     marker=gc)
ggmap(map) 




# 공공 DB 활용 

# install.packages("XML")
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc) ; top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList[1]")); df
busRouteId <- df$busRouteId
busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
# 구글 맵에 버스 위치 출력
df$gpsX <- as.numeric(as.character(df$gpsX))
df$gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=df$gpsX, lat=df$gpsY);gc
cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=gc)
ggmap(map)


library(dplyr)
library(ggmap)
library(ggplot2)

register_google(key='AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c')

geocode('Seoul', source = 'google')
geocode('Seoul', source = 'google', output = 'latlona')
geocode(enc2utf8('서울'), source = 'google')
# 위도, 경도, 주소를 리턴(영문으로 리턴)
geocode(enc2utf8('서울'), source = 'google', output = 'latlona')
# 이 경우 한글로 리턴
geocode(enc2utf8('서울&language=ko'), source = 'google', output = 'latlona')

#mutate_geocode(data.frame, address_column_name, source = 'google')
station_list = c('시청역', '을지로입구역', '을지로3가역', '을지로4가역', 
                 '동대문역사문화공원역', '신당역', '상왕십리역', '왕십리역', '한양대역', 
                 '뚝섬역', '성수역', '건대입구역', '구의역', '강변역', '잠실나루역', 
                 '잠실역', '신천역', '종합운동장역', '삼성역', '선릉역', '역삼역', 
                 '강남역', '2호선 교대역', '서초역', '방배역', '사당역', '낙성대역', 
                 '서울대입구역', '봉천역', '신림역', '신대방역', '구로디지털단지역', 
                 '대림역', '신도림역', '문래역', '영등포구청역', '당산역', '합정역', 
                 '홍대입구역', '신촌역', '이대역', '아현역', '충정로역')
station_df = data.frame(station_list, stringsAsFactors = FALSE)
station_df$station_list = enc2utf8(station_df$station_list)
station_lonlat = mutate_geocode(station_df, station_list, source = 'google')
station_lonlat
save(station_lonlat, file="station_lonlat.rda")
#load("station_lonlat.rda")
seoul_lonlat = unlist(geocode('seoul', source = 'google'))
?qmap #ggmap and get_map의 wrapper 함수(감싸고 있다는 의미)
qmap('seoul', zoom = 11)
qmap(seoul_lonlat, zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map <- qmap('Seoul', zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map + geom_point(data = station_lonlat, aes(x = lon, y = lat), colour = 'green',
                       size = 4)

# 지도 응용
df <- read.csv("전국전기차충전소표준데이터.csv", stringsAsFactors=F)       
str(df) 
head(df)
names(df)
#df_add <- as.data.frame(df[,13])
#df_add; View(df_add)
#names(df_add) <- c("address")
#head(df_add)
#df_add <- df_add %>% filter(address != "")  
#str(df_add)       
#df_add$address <- as.character(df_add$address)    
#df_add$address <- iconv(df_add$address, from="cp949", to="UTF-8") #UTF-8로 지정해주지 않으면 주소가 모두 NA가 된다.
#head(df_add)

#mut_df_add<-df[, c("경도", "위도")]
#mut_df_add <- mutate_geocode(df_add, address, source="google")
#save(mut_df_add, file="전기차.rda")
load(file="전기차.rda")
head(mut_df_add)
map_korea <- get_map(location="southKorea", zoom=7, maptype="roadmap") 
ggmap(map_korea)

ggmap(map_korea)+geom_point(data=mut_df_add, aes(x=lon, y=lat), alpha=0.5, size=2, color="red")


map_seoul <- get_map(location="seoul", zoom=11, maptype="roadmap")    
ggmap(map_seoul)+geom_point(data=mut_df_add, aes(x=lon, y=lat), alpha=0.5, size=5, color="blue")

# ------------------------------------------------
#leaflet 그리기

# install.packages("leaflet")
library(leaflet)
library(dplyr)
library(ggmap)

seoul_lonlat <- geocode("seoul")

leaflet()

leaflet() %>% addTiles()

map0 <- leaflet() %>% setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16)%>% addTiles()
map0

map1 <- map0 %>% addTiles() 
map1

mk <- 학원lonlat
lan <- mk$lon
lat <- mk$lat

msg <- '<strong><a href="http://www.multicampus.co.kr" style="text-decoration:none">멀티캠퍼스</a></strong><hr>우리가 공부하는 곳 ㅎㅎ'
# 해당 버튼을 누르면 보이게 끔
map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% 
  addTiles() %>% 
  addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 18) %>%
  addTiles() %>% 
  addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 5) %>% 
  addTiles() %>% 
  addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 1) %>% addTiles() %>% addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2


# addPopups() : 바로 팝업창 뜨게끔
content1 <- paste(sep = '<br/>',"<b><a href='https://www.seoul.go.kr/main/index.jsp'>서울시청</a></b>",'아름다운 서울','박원순 시장님 화이팅!!')
map3<-leaflet() %>% addTiles() %>%  addPopups(126.97797, 37.56654, content1, options = popupOptions() )
map3

content2 <- paste(sep = '<br/>',"<b><a href='http://www.snmb.mil.kr/mbshome/mbs/snmb/'>국립서울현충원</a></b>",'1955년에 개장', '2013년 ‘서울 미래유산’으로 등재')
# X 버튼 안 보이게
# 여러 개 팝업을 볼 수 있게끔
map3<-leaflet() %>% addTiles() %>%  
  addPopups(c(126.97797, 126.97797),  c(37.56654, 37.50124) , 
            c(content1, content2), options = popupOptions(closeButton = FALSE) )
map3

wifi_data = read.csv('wifi_data.csv', encoding = 'utf-8', stringsAsFactors = FALSE)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], 
          lat = seoul_lonlat[2], 
          zoom = 11) %>% 
  addTiles() %>% 
  addCircles(lng = ~lon, lat = ~lat) # 물결 표시 필수


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat)


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircles(lng = ~lon, lat = ~lat)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat, popup = ~div)
?colorFactor
telecom_color = colorFactor('Set1', wifi_data$div) # 색상 세트는 Set1, 데이터는 wifi_data$div

str(telecom_color)
mode(telecom_color)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat=~lat, popup = ~div, color = ~telecom_color(div))


# leaflet과 우리나라 행정구역 지도 활용
# # RStudio 를 재기동한 후에 설치한다.(안하면 재앙이 따를거임!!)
install.packages("devtools") 
devtools::install_github("cardiomoon/Kormaps")
library(Kormaps)

names(korpopmap1)
names(korpopmap2)
names(korpopmap3)
Encoding(names(korpopmap1))<-'UTF-8'
Encoding(names(korpopmap2))<-'UTF-8'
Encoding(names(korpopmap3))<-'UTF-8'
names(korpopmap1)
names(korpopmap2)
names(korpopmap3)

head(korpopmap1,1)
head(korpopmap2,1)
head(korpopmap3,1)

Encoding(korpopmap2@data$name)<-'UTF-8'
Encoding(korpopmap2@data$행정구역별_읍면동)<-'UTF-8'

korpopmap2@data <- korpopmap2@data[-26:-251,]
korpopmap2@polygons<-korpopmap2@polygons[-26:-251]
mymap <- korpopmap2@data
head(mymap)
View(korpopmap2)

crime <- read.csv('2017crime.csv')
head(crime)
palette1<-colorNumeric(palette = 'Oranges', domain = crime$살인_발생)
popup1 <- paste0(mymap$name,'<br> 살인 : ',crime$살인_발생, '건')
map4<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup1, color=~palette1(crime$살인_발생), group='살인')
map4


palette2<-colorNumeric(palette = 'Blues', domain = crime$폭력_발생)
popup2 <- paste0(mymap$name,'<br> 폭력 : ',crime$폭력_발생, '건')
map5<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup2, color=~palette2(crime$폭력_발생), group='폭력')
map5


palette3<-colorNumeric(palette = 'Reds', domain = crime$범죄_발생_총합)
popup3 <- paste0(mymap$name,'<br> 범죄_발생_총합 : ',crime$범죄_발생_총합, '건')
map6<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup3, color=~palette3(crime$범죄_발생_총합),group='총 범죄')

map6

palette2<-colorNumeric(palette = 'Blues', domain = crime$폭력_발생)
popup2 <- paste0(mymap$name,'<br> 폭력 : ',crime$폭력_발생, '건')
map8<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup2, color=~palette2(crime$폭력_발생), group='폭력') %>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup3, color=~palette3(crime$범죄_발생_총합),group='총 범죄')
map8
