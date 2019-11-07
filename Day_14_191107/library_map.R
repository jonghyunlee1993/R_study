rm(list = ls())

library(ggplot2)
library(ggmap)
library(dplyr)

# Q2

data = read.csv("지역별장애인도서관정보.csv", stringsAsFactors = F)

libraries = data %>% select(도서관명, lon = LON, lat = LAT) %>% as.data.frame
cen <- c(mean(libraries$lon), mean(libraries$lat))

map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 11)
ggmap(map) +
  geom_point(data = libraries, colour = 'red', size = 4, alpha = 0.5) +
  geom_label(data = libraries, label = libraries$도서관명, nudge_x = 0.04, alpha = 0, label.size = NA)

# ggmap(map) +
#   geom_point(data = libraries, colour = 'red', size = 4, alpha = 0.5) +
#   geom_text(data = libraries, aes(x = libraries$lon, y = libararies$lat), label = labraries$도서관명, vjust = 0, hjust = 0)


ggsave("library_map.png")


# libraries$addr = enc2utf8(as.character(libraries$주소))
# libraries_lonlat = geocode(libraries$addr)
# lib_name = data.frame(libraries$도서관명, libraries_lonlat)
# ggmap(map) + 
#   geom_point(data = libraries_lonlat, colour = 'red', size = 4) +
#   # geom_text(data = lib_name, label = lib_name$libraries.도서관명, nudge_x = 0.05, size = 2.5)
#   geom_label(data = lib_name, label = lib_name$libraries.도서관명, nudge_x = 0.05, alpha = 0, label.size = NA)

