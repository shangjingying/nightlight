library(raster)
library(sp)
library(rgdal)
library(tmap)
library(RColorBrewer)
library(grid)
library(RColorBrewer)
library(animation)
install_github("16EAGLE/moveVis")
library(moveVis)
library(magick)


dir()
dir("raster")


# Use raster() with file path: 
korean1992 <- raster("raster/korean 1992/Korean92.tif")
korean2012 <- raster("raster/korean 2012/Korean20121.tif")



# Specify pop as the shp and add a tm_raster() layer
tmap_mode('view')
dir()
dir("1992")
file.exists('C:/Users/54454/Desktop/1992/countries.shp')
s <- shapefile("C:/Users/54454/Desktop/1992/countries.shp")

Korean<-s[s$OBJECTID=="222"|s$OBJECTID=="177",]

# Plot the under_1 layer in pop_by_age
intuitive_cols <- c(
  "navy",
  "lightblue",
  "gold",
  "red"
  
)

#Korean
map_KR1992=tm_shape(Korean) +
  tm_borders(col="white")+tm_shape(korean1992) +tm_raster(palette = intuitive_cols,
                        style = "fixed",title =" Korean Peninsula(1992)", breaks = c(0, 20, 40, 60,63),
                        alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                        = c(plot = 1030370, view = 1030370));map_KR1992

map_KR2012=tm_shape(Korean) +
  tm_borders(col="white")+tm_shape(korean2012) +tm_raster(palette = intuitive_cols,
                        style = "fixed",title =" Korean Peninsula(2012)", breaks = c(0, 20, 40, 60,63),
                        alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                        = c(plot = 1030370, view = 1030370));map_KR2012

tmap_mode('view')


map_DE1992+tm_scale_bar(breaks = c(0, 100, 200), size = 1)+tm_layout(inner.margins = 0.2)





# Indonesia
dir()
dir("raster")
Indonesia1997 <- raster("raster/indoni 97/Indonesia 97.tif")
Indonesia1998 <- raster("raster/indoni98/indonesia98.tif")

Indonesia<-s[s$OBJECTID=="114",]

map_In1997=tm_shape(Indonesia) +
  tm_borders(col="white")+tm_shape(Indonesia1997) +tm_raster(palette = intuitive_cols,
            style = "fixed",title =" Indonesia(1997)", breaks = c(0, 20, 40, 60,63),
            alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
            = c(plot = 1030370, view = 1030370));map_In1997

map_In1998=tm_shape(Indonesia) +
  tm_borders(col="white")+tm_shape(Indonesia1998) +tm_raster(palette = intuitive_cols,
           style = "fixed",title ="Indonesia(1998)", breaks = c(0, 20, 40, 60,63),
           alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
           = c(plot = 1030370, view = 1030370));map_In1998


#changes
blups <- brewer.pal(4, "Set3")
outputRaster <- overlay(Indonesia1997, Indonesia1998, fun=function(r1, r2){return(r2-r1)})
map_In19978=tm_shape(Indonesia) +
  tm_borders(col="white")+tm_shape(outputRaster) +tm_raster(palette =blups,
  style = "fixed",title ="Indonesia(1997-1998)", breaks = c(-10, -3, 0, 3,12),
  alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
  = c(plot = 1030370, view = 1030370));map_In19978

tmap_mode("view")

#Madagascar
dir()
dir("raster")
Madagascar1998 <- raster("raster/Madagascar 98/Madagascar98.tif")
Madagascar1999 <- raster("raster/Madagascar 99/Madagascar99.tif")
Madagascar2003 <- raster("raster/Madagascar 03/Madagascar03.tif")
Madagascar2004 <- raster("raster/Madagascar 08/Madagascar04.tif")
Madagascar<-s[s$OBJECTID=="145",]

tmap_mode("plot")

#98
intuitive_cols2 <- c(
  "oldlace",
  "orange2",
  "orange3",
  "orange4"
  
)

nz_region = st_bbox(c(xmin = 45, xmax = 46,
                      ymin = -23, ymax = -22),
                    crs = st_crs(Madagascar1998)) %>% 
  st_as_sfc()


nz_height_map1 = tm_shape(Madagascar1998, bbox = nz_region) +
  tm_raster(palette =intuitive_cols2, legend.show = TRUE,midpoint = 0, breaks = c(0, 2, 4, 6,10))  +
  tm_scale_bar(position = c("left", "bottom"))
nz_height_map1

nz_map = tm_shape(Madagascar) + tm_polygons(alpha = 0.3) +
  tm_shape(nz_region) + tm_borders(lwd = 3) 
nz_map

nz_height_map1


#99
intuitive_cols1 <- c(
  "white",
  "azure3",
  "azure4",
  "grey13"
  
)

nz_region = st_bbox(c(xmin = 45, xmax = 46,
                      ymin = -23, ymax = -22),
                    crs = st_crs(Madagascar1998)) %>% 
  st_as_sfc()

nz_region

nz_height_map2 = tm_shape(Madagascar1999, bbox = nz_region) +
  tm_raster(palette =intuitive_cols2, legend.show = TRUE,midpoint = 0, breaks = c(0, 2, 4, 6, 63))  +
  tm_scale_bar(position = c("left", "bottom"))
nz_height_map2

nz_map = tm_shape(Madagascar) + tm_polygons(alpha = 0.3) +
  tm_shape(nz_region) + tm_borders(lwd = 3) 
nz_map

nz_height_map2
print(nz_map, vp = viewport(0.69, 0.17, width = 0.3, height = 0.3))

#03
map_Ma98=tm_shape(Madagascar) +
  tm_borders(col="white")+tm_shape(Madagascar1998) +tm_raster(palette =intuitive_cols,
                                                              style = "fixed",title ="Indonesia(1997-1998)", breaks = c(0, 1, 2, 3,63),
                                                              alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                                                                                                                                                          = c(plot = 1030370, view = 1030370));map_Ma98

nz_region = st_bbox(c(xmin = 45, xmax = 46,
                      ymin = -23, ymax = -22),
                    crs = st_crs(Madagascar1998)) %>% 
  st_as_sfc()


nz_height_map3 = tm_shape(Madagascar2003, bbox = nz_region) +
  tm_raster(palette =intuitive_cols2, legend.show = TRUE,midpoint = 0, breaks = c(0, 2, 4, 6,10))  +
  tm_scale_bar(position = c("left", "bottom"))


nz_map = tm_shape(Madagascar) + tm_polygons(alpha = 0.3) +
  tm_shape(nz_region) + tm_borders(lwd = 3) 
nz_map

nz_height_map3

#13
nz_height_map4 = tm_shape(Madagascar2004, bbox = nz_region) +
  tm_raster(palette =intuitive_cols2, legend.show = TRUE,midpoint = 0, breaks = c(0, 2, 4, 6,10))  +
  tm_scale_bar(position = c("left", "bottom"))
nz_height_map4
tmap_arrange(nz_height_map1,nz_height_map2,nz_height_map3,nz_height_map4)

print(nz_map, vp = viewport(0.43, 0.13, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.43, 0.63, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.93, 0.63, width = 0.2, height = 0.2))
print(nz_map, vp = viewport(0.93, 0.13, width = 0.2, height = 0.2))    

setwd("C:/Users/54454/Desktop/raster/germany93-02")

#my attempt to create a list of my .tif files for lapply
Germany = list.files(pattern="*.tif")

#trying to use the raster function to read all .tif files
myfiles_Germany = lapply(Germany, raster)

layer <- myfiles_Germany #list of rasters

#Get your convert directory/command
conv_dir <- get_libraries()

#Specify the output directory, e.g.
out_dir <- "C:/Users/54454/Desktop/raster/germany93-02"

#Call animate_raster
animate_raster(layer,out_dir = out_dir,conv_dir=conv_dir,frames_fps = 1,
               layer_col = c("navy", "lightblue", "gold","red"),out_format = "gif",
               img_title = "Germany1993-2003", 
               legend_title = "DN",
               frames_nres = 1, 
               frames_pixres = 150,
               out_name = "moveVis1",  overwrite = TRUE,time_bar_col="white",
               time_size=1
)
