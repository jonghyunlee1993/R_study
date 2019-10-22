rm(list=ls())

# LDA
install.packages("MASS")
library(MASS)

data(iris)
ldaobj = lda(Species ~ ., data=iris)
ldapred = predict(ldaobj)$posterior
ldapred

# 시각화 및 모델 파라미터 최적화 패키지
install.packages("klaR")
library(klaR)

data(B3)
str(B3)

# 최적 파라미터 추출을 위한 greedy.wilks 메서드, niveau는 F-test의 p value
gw_obj = greedy.wilks(PHASEN ~ ., data = B3, niveau = 0.1)
gw_obj

plineplot(Species ~., data = iris, method = 'lda', 
          x = iris[,4], xlab = "Petal.Width")

mN = NaiveBayes(Species ~ ., data =iris)
par(mfrow=c(2,2))
plot(mN)

# party / binning을 위한 패키지
# binning은 연속형 변수를 범주형으로 바꿔주는 것을 의미함

