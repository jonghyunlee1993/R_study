library(dplyr)
library(MASS)

############################################################
########################## t test  #########################
############################################################

# swiss datasets
# education 높은 그룹과 낮은 그룹의 출생률 차이
rm(list = ls())
data = swiss

criteria = mean(data$Education)
data = data %>% 
  mutate(HL_edu = ifelse(Education >= criteria, 1, 0))

t.test(Fertility ~ HL_edu, data = data)

# mpg datasets
# a4 모델과 civic 모델의 도시 연비 비교
rm(list = ls())

mpg_1 = mpg %>%
  filter(model =='a4'| model == "civic")

t.test(cty ~ model, data = mpg_1)

# ford와 honda의 도시 연비 비교
mpg_2 = mpg %>%
  filter(manufacturer == 'ford' | manufacturer == "honda")

t.test(cty ~ manufacturer, data = mpg_2)

# suv와 compact의 도시 연비 비교
mpg_3 = mpg %>%
  filter(class == 'suv'| class == "compact")

t.test(cty ~ class, data = mpg_3)

# suv와 midsize의 고속도로 연비 비교

data <- mpg %>%
  filter(class=='suv' | class == 'midsize') %>%
  select(hwy, class)

t.test(hwy ~ class, data = data)


#h0 midsize와 hwy의 평균은 서로 같을 것이다.
#h1 midsize와 hwy의 평균은 서로 다르다. 

#대립가설 채택 : p-value < 2.2e-16 


############################################################
##################### f test ANOVA #########################
############################################################

# mtcars datasets
# 실린더의 개수의 마력 차이
rm(list = ls())

data = mtcars
summary(aov(mpg ~ cyl, data))

# 
rm(list = ls())

data = Cars93
summary(aov(Price ~ Manufacturer, data))

# f test 3
rm(list = ls())

data = Cars93
summary(aov(MPG.city ~ Cylinders + Type, data))

# f test using mpg
result1 = aov(cty ~ manufacturer, data = mpg)
result2 = aov(hwy ~ manufacturer, data = mpg)
result3 = aov(hwy ~ model, data = mpg)

############################################################
#################### chi square test #######################
############################################################

# 자동차 type 별 airbag 터지는 횟수 차이 발생하냐
rm(list = ls())

data = data.frame(Cars93$AirBags, Cars93$Type)
data = table(Cars93$AirBags, Cars93$Type) 
chisq.test(data)

# 호주의 거주지별 에이즈 생존/사망
rm(list = ls())

data = Aids2
freq = table(data$state, data$status)
chisq.test(freq)
# 거주지의 영향이 없음


# 약물과 위약의 치료 효과 검증
rm(list = ls())

therapy = c(75, 25)
placebo = c(58, 42)

data = data.frame(therapy, placebo)
rownames(data) = c("Yes", "No")

chisq.test(data)



#카이제곱 분포
#A약을 먹은 그룹1과 비타민을 먹은 그룹2가 있을 때,
#두 그룹이 감기에 걸릴 (disease=1) 확률이 같은지
#카이제곱 검정을 이용하여 연구하고자 한다.
#동질성 검정


group <- c(rep(1,54), rep(2,50))
set.seed(7)
disease <- c(rbinom(n = 104, size = 1, prob = 0.25))+1
data <- data.frame(group, disease)
head(data)

tab <- table(data)
tab

tab_t <- t(tab)
tab_t

chisq.test(tab, correct=FALSE)

prop.test(tab, correct=F)


#P-value = 0.02577로 0.05보다 작은 것으로 확인.
#따라서 두 그룹 간에 감기에 걸릴 비율은 같지 않음.

#동질성 검정, 카이제곱 분포 사례
#H0: 남녀의 TV 선호도는 동일하다.
#H1: H0이 아니다.

row_1 <- c(50, 30, 20)
row_2 <- c(50, 80, 70)

data_rbind <- rbind(row_1, row_2)
data_rbind

raw_data <- c(50, 30, 20, 50, 80, 70)
data_matrix <- matrix(raw_data, byrow = TRUE, nrow = 2)
data_matrix

dimnames(data_matrix) <- list("Gender" = c("Boys", "Girls"),
                              "TV_Preferences" = c("Pororo", "JJangGu", "RobotCar"))
data_matrix

addmargins(data_matrix)
prop.table(data_matrix)
addmargins(prop.table(data_matrix))
chisq.test(data_matrix)

#카이제곱 통계량 값이 19.318이 나왔고
#P-value가 6.384e-05 로서
#유의수준 α 0.05 보다 훨씬 작기때문에
#귀무가설 H0 를 기각하고 대립가설 H1을 채택하여
#"남학생/여학생별 선호하는 TV프로그램은 동일하지 않다"고 판단.


