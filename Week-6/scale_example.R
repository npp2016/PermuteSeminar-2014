l1 <- 20000
l2 <- 100
l3 <- 10
x <- 1:10000

y <- cos(2 * pi / l1 * x) + cos(2 * pi / l2 * x) + cos(2 * pi / l3 * x)

par(mfrow=c(2, 1))
plot(x[1:1000], y[1:1000], ty='l', xlab='x', ylab='y')

sample.points <- sample.int(1000, size=100)
x.sample <- x[sample.points]
y.sample <- y[sample.points]

points(x.sample, y.sample, pch=16)

min.lag <- abs(min(diff(sort(x.sample))))
max.lag <- abs(diff(range(x.sample)))
scope <- max.lag / min.lag

plot(x.sample[order(x.sample)], y.sample[order(x.sample)], ty='b', 
     xlab='x', ylab='y')
