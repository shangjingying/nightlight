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


#Madagascar

tmap_mode("plot")
# extract Madagascar shapefile
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



#plot the shapefile map of Madagascar with marked sign
nz_map = tm_shape(Madagascar) + tm_polygons(alpha = 0.3) +
  tm_shape(nz_region) + tm_borders(lwd = 3) 
nz_map
#combine multiple plots in one graph
tmap_arrange(nz_height_map1,nz_height_map2,nz_height_map3,nz_height_map4)
#print marked profile map on base map
print(nz_map, vp = viewport(0.43, 0.13, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.43, 0.63, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.93, 0.63, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.93, 0.13, width = 0.2, height = 0.2))    

#Animation of Germany

#creat a file(germany93-02) includes all data as format .tif
setwd("C:/Users/54454/Desktop/raster/germany93-02")

#my attempt to create a list of my .tif files for lapply
Germany = list.files(pattern="*.tif")

#trying to use the raster function to read all .tif files
myfiles.Germany = lapply(Germany, raster)

layer = myfiles.Germany #list of rasters

#Get your convert directory/command
#It is really important to download ImageMagick and 
#click "the Install legacy utilities option" during installation
conv_dir = get_libraries()

#Specify the output directory, e.g.
out_dir = "C:/Users/54454/Desktop/raster/germany93-02"

#Call animate_raster
animate_raster(layer,out_dir = out_dir,conv_dir=conv_dir,frames_fps = 1,
               layer_col = c("navy", "lightblue", "gold","red"),out_format = "gif",
               img_title = "Germany1993-2003", 
               legend_title = "DN",
               frames_nres = 1, 
               frames_pixres = 150,
               out_name = "moveVis1",  overwrite = TRUE,
               time_size=1,
               scalebar_dist="auto"
)


                                                                                                                                                         