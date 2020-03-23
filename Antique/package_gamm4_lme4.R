library(gamm4)
library(splines)

set.seed(1)

n = 100
pSimulation = 3
pStatistical = 8

x = rnorm(n)
Bsimulation = ns(x, pSimulation)
Bstatistical = ns(x, pStatistical)
beta = rnorm(pSimulation)

y = as.numeric(Bsimulation %*% beta + rnorm(n, sd=0.3))

par(mar=c(4, 4, 1, 1), las=1, bty="l")
plot(x, y, las=1)
lines(x[order(x)], (Bsimulation %*% beta)[order(x)])

pseudoGroups = as.factor(rep(1:pStatistical, length=n))
parsedFormula = lFormula(y ~ x + (1 | pseudoGroups))

parsedFormula$reTrms <- within(parsedFormula$reTrms, {
  Bt <- t(as.matrix(Bstatistical))[]
  cnms$pseudoGroups <- "spline"
  Zt <- as(Bt, class(Zt))
})

devianceFunction = do.call(mkLmerDevfun, parsedFormula)
optimizerOutput = optimizeLmer(devianceFunction)
mSpline <- mkMerMod( rho = environment(devianceFunction),
                     opt = optimizerOutput,
                     reTrms = parsedFormula$reTrms,
                     fr = parsedFormula$fr )

mSpline

xNew <- seq(min(x), max(x), length = 100)
newBstatistical <- predict(Bstatistical, xNew)
yHat <- cbind(1, xNew) %*% getME(mSpline, "fixef") +
  newBstatistical %*% getME(mSpline, "u")
par(mar = c(4, 4, 1, 1), las = 1, bty = "l")
plot(x, y)
lines(xNew, yHat)
lines(x[order(x)], (Bsimulation %*% beta)[order(x)],lty = 2)
legend("topright", bty = "n", c("fitted", "generating"), lty = 1:2,col = 1)

