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



# Indonesia
#extract shapefile of Indonesia
tmap_mode('view')
setwd("C:/Users/54454/Desktop/raster/1992")
file.exists('C:/Users/54454/Desktop/raster/1992/countries.shp')
s = shapefile("C:/Users/54454/Desktop/raster/1992/countries.shp")
Indonesia=s[s$OBJECTID=="114",]

i2=c("result$Indonesia97","result$indonesia98")
fun2=function(i2){tm_shape(Indonesia) +
    tm_borders(col="white")+tm_shape(result$Indonesia97) +tm_raster(palette = intuitive_cols,
                                                                style = "fixed",title =" Indonesia", breaks = c(0, 20, 40, 60,63),
                                                                alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                                                                = c(plot = 11209660, view = 11209660))}

plot2=lapply(i2,fun2)
names(plot2)=c("indonesia97","indonesia98")
plot2$indonesia97
plot2$indonesia98


#changes
blups = brewer.pal(4, "Set3")
outputRaster = overlay(result$Indonesia97, result$indonesia98, fun=function(r1, r2){return(r2-r1)})
map_In19978=tm_shape(Indonesia) +
  tm_borders(col="white")+tm_shape(outputRaster) +tm_raster(palette =blups,
                                                            style = "fixed",title ="Indonesia(1997-1998)", breaks = c(-10, -3, 0, 3,12),
                                                            alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                                                                                                                                                        = c(plot = 1030370, view = 1030370));map_In19978
