require(splines)
require(ISLR)
attach(Wage)

?Wage
agelims <- range(age)
age.grid<-seq(from=agelims[1], to = agelims[2])

fit<-lm(wage ~ bs(age, knots = c(25, 40, 60)), data=Wage )
summary(fit)

# Plotting the Regression Line to the scatterplot   
plot(age, wage, col="grey", xlab="Age", ylab="Wages")
points(age.grid,predict(fit, newdata = list(age=age.grid)), col="darkgreen", lwd=2, type="l")

# adding cutpoints
abline(v = c(25, 40, 60), lty=2, col="darkgreen") 


