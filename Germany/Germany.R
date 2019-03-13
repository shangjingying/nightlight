#Animation of Germany
setwd("C:/Users/54454/Desktop/raster/germany93-02")

#my attempt to create a list of my .tif files for lapply
Germany = list.files(pattern="*.tif")

#trying to use the raster function to read all .tif files
myfiles_Germany = lapply(Germany, raster)

layer = myfiles_Germany #list of rasters

#Get your convert directory/command
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


