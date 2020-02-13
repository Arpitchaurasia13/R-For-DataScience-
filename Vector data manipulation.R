f <- system.file("external/lux.shp", package="raster")
library(raster)
p <- shapefile(f)
p

par(mai=c(0,0,0,0))
plot(p)

d <- data.frame(p)
head(d)

g <- geom(p)
head(g)

p$NAME_2
p[, 'NAME_2']


set.seed(0)
p$new <- sample(letters, length(p))
p

p$new <- sample(LETTERS, length(p))
p


p$new <- NULL


dfr <- data.frame(District=p$NAME_1, Canton=p$NAME_2, Value=round(runif(length(p), 100, 1000)))
dfr <- dfr[order(dfr$Canton), ]
pm <- merge(p, dfr, by.x=c('NAME_1', 'NAME_2'), by.y=c('District', 'Canton'))
pm  

i <- which(p$NAME_1 == 'Grevenmacher')
g <- p[i,]
g


z <- raster(p, nrow=2, ncol=2, vals=1:4)
names(z) <- 'Zone'

z <- as(z, 'SpatialPolygonsDataFrame')
z

z2 <- z[2,]
plot(p)
plot(z, add=TRUE, border='blue', lwd=5)
plot(z2, add=TRUE, border='red', lwd=2, density=3, col='red')


b <- bind(p, z)
head(b)

tail(b)


pa <- aggregate(p, by='NAME_1')
za <- aggregate(z)
plot(za, col='light gray', border='light gray', lwd=5)
plot(pa, add=TRUE, col=rainbow(3), lwd=3, border='white')


zag <- aggregate(z, dissolve=FALSE)
zag

plot(zag, col="light gray")

install.packages("rgeos")
library(rgeos)

zd <- disaggregate(zag)
zd



e <- erase(p, z2)
e <- p - z2
plot(e)


i <- intersect(p, z2)
plot(i)


i <- p * z2


e <- extent(6, 6.4, 49.7, 50)
pe <- crop(p, e)
plot(p)
plot(pe, col='light blue', add=TRUE)
plot(e, add=TRUE, lwd=3, col='red')


u <- union(p, z)
u <- p + z
u

set.seed(5)
plot(u, col=sample(rainbow(length(u))))


cov <- cover(p, z)
cov

plot(cov)


dif <- symdif(z,p)
plot(dif, col=rainbow(length(dif)))

dif



pts <- matrix(c(6, 6.1, 5.9, 5.7, 6.4, 50, 49.9, 49.8, 49.7, 49.5), ncol=2)
spts <- SpatialPoints(pts, proj4string=crs(p))
plot(z, col='light blue', lwd=2)
points(spts, col='light gray', pch=20, cex=6)
text(spts, 1:nrow(pts), col='red', font=2, cex=1.5)
lines(p, col='blue', lwd=2)


over(spts, p)
over(spts, z)
extract(z, pts)
