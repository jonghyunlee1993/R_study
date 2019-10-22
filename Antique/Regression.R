rm(list=ls())

# 단순 선형 회귀
set.seed(2)
x = runif(10, 0, 11)
y = runif(10, 11, 20)

df = data.frame(x,y)
print(df)

model = lm(y~x, data=df)
print(model)

# 다중 선형 회귀
rm(list=ls())

set.seed(2)
y = runif(10, -10, 20)
u = runif(10, 0, 11)
v = runif(10, 11, 20)
w = runif(10, 21, 30)

df = data.frame(y, u, v, w)
print(df)

model = lm(y ~ u + v + w)
print(model)
summary(model)
plot(model)

# cars 데이터 셋에 대해서 실습
data(cars)
str(cars)
speed2 = cars$speed^2
cars = cbind(cars, speed2)
model_cars = lm(dist ~ speed + speed2, data=cars)
summary(model_cars)
plot(model_cars)

# 최적회귀방정식 선택: 전진 및 후진 선택법
rm(list=ls())

X1 = c(7, 1, 11, 11, 7, 11, 3, 1, 2, 21, 1, 11, 10)
X2 = c(26, 29, 56, 31, 52, 55, 71, 31, 54, 47, 40, 66, 68)
X3 = c(6, 15, 8, 8, 6, 9, 17, 22, 18, 4, 23, 9, 8)
X4 = c(60, 52, 20, 47, 33, 22, 6, 44, 22, 26, 34, 12, 12)
Y = c(78.5, 74.3, 104.3, 87.6, 95.9, 109.2, 102.7, 72.5, 93.1, 
      115.9, 83.8, 113.3, 109.4)
df = data.frame(X1, X2, X3, X4, Y)

step(lm(Y ~ 1, df), scope=list(lower=~1, upper=~X1+X2+X3+X4), direction="forward")
step(lm(Y ~ X1+X2+X3+X4, df), direction="backward", trace=FALSE)
step(lm(Y ~ X1+X2+X3+X4, df), scope=list(lower=~1, upper=~X1+X2+X3+X4), direction="both")
