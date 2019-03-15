library(raster)
library(sp)
library(rgdal)
library(tmap)
library(RColorBrewer)
library(grid)
library(animation)
library(moveVis)
library(magick)
#Animation of Germany£¨create a file containing all data)
setwd("C:/Users/54454/Desktop/raster/germany93-02")

#my attempt to create a list of .tif files for lapply
Germany = list.files(pattern="*.tif")

#trying to use the raster function to read all .tif files
myfiles.Germany = lapply(Germany, raster)

layer = myfiles.Germany #list of rasters

#It is really important to download ImageMagick and click "the Install legacy
#utilities option" during installation
#Get your convert directory/command
conv.dir = get_libraries()

#Specify the output directory, e.g.
out_dir = "C:/Users/54454/Desktop/raster/germany93-02"

#Call animate_raster
animate_raster(layer,out_dir = out_dir,conv_dir=conv.dir,frames_fps = 1,
               layer_col = c("navy", "lightblue", "gold","red"),out_format = "gif",
               img_title = "Germany1993-2003", 
               legend_title = "DN",
               frames_nres = 1, 
               frames_pixres = 150,
               out_name = "moveVis1",  overwrite = TRUE,
               time_size=1,
               scalebar_dist="auto"
)

