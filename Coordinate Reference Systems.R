install.packages("rgdal")
library(rgdal)
epsg <- make_EPSG()
i <- grep("France", epsg$note, ignore.case=TRUE)
epsg[i[1:3], ]


library(raster)
library(rgdal)
f <- system.file("external/lux.shp", package="raster")
p <- shapefile(f)
p

crs(p)
pp <- p
crs(pp) <- NA
crs(pp)

newcrs <- CRS("+proj=robin +datum=WGS84")
rob <- spTransform(p, newcrs)
rob


