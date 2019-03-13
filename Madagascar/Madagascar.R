#Madagascar

tmap_mode("plot")
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


