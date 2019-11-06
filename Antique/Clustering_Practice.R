rm(list=ls())

data(iris)

# kmeans

new_iris = iris
new_iris$Species = NULL
kc = kmeans(new_iris, 3)
table(iris$Species, kc$cluster)

plot(new_iris[c("Sepal.Length", "Sepal.Width")], col = kc$cluster)
plot(new_iris[c("Petal.Length", "Petal.Width")], col = kc$cluster)

# hierarchical clustering

idx = sample(1:dim(iris)[1], 40)
iris.s = iris[idx,]
iris.s$Species = NULL
hc = hclust(dist(iris.s), method = "ave")
plot(hc, hang = -1, labels = iris$Species[idx])
plot(hc, hang = -1, labels = iris$Species[idx])
