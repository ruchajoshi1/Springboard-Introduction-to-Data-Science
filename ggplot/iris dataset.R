levels(iris$Species) <- c("Setosa","Versicolor","Virginica")
levels(iris$Species)
ggplot(iris, aes(x = Sepal.Length, y=Sepal.Width)) + facet_grid(. ~ Species) + geom_jitter(alpha = 0.6)


levels(iris$Species) <- c("a","b","c")
head(iris)
