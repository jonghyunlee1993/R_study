rm(list=ls())

library(dplyr)

data(mtcars)

# data 확인
nrow(mtcars)
str(mtcars)

# filter 함수 / 동일 함수가 있어서 :: 으로 파싱
dplyr::filter(mtcars, cyl == 4)
dplyr::filter(mtcars, cyl >= 6 & mpg > 20)

# arrange 함수 / 정렬
head(arrange(mtcars, wt))
head(arrange(mtcars, mpg, desc(wt)))

# select 함수 / 특정 column 만 파싱
head(select(mtcars, am, gear))

# 
select(dplyr::filter(mtcars, cyl == 4), am, gear)

# mutate 함수 / 새로운 열을 추가
head(mutate(mtcars, years = "1974"))
head(mutate(mtcars, mpg_rank = rank(mpg)))

# distinct 함수 / 중복 값 제거
distinct(mtcars, cyl)

#group_by 함수 / 그룹별로 나눠줌
data(mtcars)
gr_cyl = group_by(mtcars, cyl)
head(gr_cyl)
summarise(gr_cyl, n()) # n()은 카운트 해주는 함수
summarise(gr_cyl, n_distinct(gear)) # gear 중복값 제외하고 cyl별 개수 요약

# sample_n 함수 / 특정 개수의 샘플 추출
sample_n(mtcars,10)

# sample_frac 함수 / 비율로 샘플 추출
sample_frac(mtcars, 0.2)

# pipe 이용
group_by(mtcars, cyl) %>% summarise(n())
mutate(mtcars, mpg_rank = rank(mpg)) %>% arrange(mpg_rank)

temp = iris %>% subset(Sepal.Length > 5) %>%
  aggregate(. ~ Species, ., mean) # Species를 기준으로 모든 행의 평균 계산

temp2 = mtcars %>% aggregate(wt ~ carb + gear, ., mean) # carb, gear 행을 기준으로 wt의 평균 계산
print(temp2)

mpg_result = mpg %>% mutate(total = cty + hwy) %>%
  mutate(mean = total / 2) %>% arrange(desc(mean)) %>%
  head()

