library(raster)
library(sp)
library(rgdal)
library(tmap)
library(RColorBrewer)
library(grid)
library(animation)
library(moveVis)
library(magick)


# load data, the path is changeable 

setwd("C:/Users/54454/Desktop/nightlights-data")
i=c("korean92.tif","Korean2012.tif","Indonesia 97.tif","indonesia98.tif",
    "Madagascar98.tif","Madagascar99.tif","Madagascar03.tif","Madagascar04.tif")
fun=function(i){raster(i)}
result=lapply(i,fun)
names(result)=c("korea92","Korea12","Indonesia97","indonesia98",
                "Madagascar98","Madagascar99","Madagascar03","Madagascar04")


# extract korea shapefile
setwd("C:/Users/54454/Desktop/raster/1992")
file.exists('C:/Users/54454/Desktop/raster/1992/countries.shp')
s = shapefile("C:/Users/54454/Desktop/raster/1992/countries.shp")

Korean=s[s$OBJECTID=="222"|s$OBJECTID=="177",]

# define the color
intuitive_cols = c(
  "navy",
  "lightblue",
  "gold",
  "red"
)

#Korean
tmap_mode('view')
i1=c("result$korea92","result$korea12")
#by using package tmap to plot raster on shapefile
fun1=function(i1){tm_shape(Korean) +
    tm_borders(col="white")+tm_shape(result$korea92) +tm_raster(palette = intuitive_cols,
                                                                style = "fixed",title =" Korea Peninsula(1992)", breaks = c(0, 20, 40, 60,63),
                                                                alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                                                                                                                                                            = c(plot = 1030370, view = 1030370))}
plot=lapply(i1,fun1)
names(plot)=c("Korea92","Korea12")
plot$Korea92
plot$Korea12
