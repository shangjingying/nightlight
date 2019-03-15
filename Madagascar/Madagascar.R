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



#Madagascar

#change emviroment
tmap_mode("plot")

#extract Madagascar shapefile
setwd("C:/Users/54454/Desktop/raster/1992")
file.exists('C:/Users/54454/Desktop/raster/1992/countries.shp')
s = shapefile("C:/Users/54454/Desktop/raster/1992/countries.shp")
Madagascar=s[s$OBJECTID=="145",]

#locate the area where we are interested in
blups = brewer.pal(4, "Set3")
t=tm_shape(result$Madagascar98)+tm_raster(palette =blups)
nz_region = st_bbox(c(xmin = 45, xmax = 46,
                      ymin = -23, ymax = -22),
                    crs = st_crs(Madagascar)) %>% 
  st_as_sfc()

#plot the area we are interested in(the function dosen't apply to this code, so l write them seperately)
#98
nz_height_map1 = tm_shape(result$Madagascar98, bbox = nz_region) +
  tm_raster(palette =intuitive_cols,midpoint = 0, breaks = c(0, 2, 4, 6,10))  +tm_legend(outside=FALSE,text.color="white")+
  tm_scale_bar(position = c("left", "bottom"),text.color = "white")+tmap_options(max.raster = c(plot = 1437516, view = 1437516))

#99
nz_height_map2 = tm_shape(result$Madagascar99, bbox = nz_region) +
  tm_raster(palette =intuitive_cols, legend.show = TRUE,midpoint = 0, breaks = c(0, 2, 4, 6,10))  +
  tm_scale_bar(position = c("left", "bottom"),text.color = "white")+tmap_options(max.raster = c(plot = 1437516, view = 1437516))+
  tm_legend(outside=FALSE,text.color="white")

#03

nz_height_map3 = tm_shape(result$Madagascar03, bbox = nz_region) +
  tm_raster(palette =intuitive_cols, legend.show = TRUE,midpoint = 0, breaks = c(0, 2, 4, 6,10))  +
  tm_scale_bar(position = c("left", "bottom"),text.color = "white")+tmap_options(max.raster = c(plot = 1437516, view = 1437516))+
  tm_legend(outside=FALSE,text.color="white")
#04
nz_height_map4 = tm_shape(result$Madagascar04, bbox = nz_region) +
  tm_raster(palette =intuitive_cols, legend.show = TRUE,midpoint = 0, breaks = c(0, 2, 4, 6, 63))  +
  tm_scale_bar(position = c("left", "bottom"),text.color = "white")+tmap_options(max.raster = c(plot = 1437516, view = 1437516))+
  tm_legend(outside=FALSE,text.color="white")






#plot the map of Madagascar
nz_map = tm_shape(Madagascar) + tm_polygons(alpha = 0.3) +
  tm_shape(nz_region) + tm_borders(lwd = 3) 
nz_map

tmap_arrange(nz_height_map1,nz_height_map2,nz_height_map3,nz_height_map4)

print(nz_map, vp = viewport(0.43, 0.13, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.43, 0.63, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.93, 0.63, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.93, 0.13, width = 0.2, height = 0.2))    

