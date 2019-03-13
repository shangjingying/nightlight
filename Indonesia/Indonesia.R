
# Indonesia
#extract shapefile of Indonesia
Indonesia=s[s$OBJECTID=="114",]

i2=c("result$Indonesia97","result$indonesia98")
fun2=function(i2){tm_shape(Indonesia) +
    tm_borders(col="white")+tm_shape(i2) +tm_raster(palette = intuitive_cols,
                                                    style = "fixed",title =" Indonesia(1997)", breaks = c(0, 20, 40, 60,63),
                                                    alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                                                                                                                                                = c(plot = 1030370, view = 1030370))}
plot2=lapply(i2,fun2)
names(plot2)=c("indonesia97","indonesia98")
plot2$indonesia97
plot2$indonesia98


#changes
blups = brewer.pal(4, "Set3")
outputRaster = overlay(Indonesia1997, Indonesia1998, fun=function(r1, r2){return(r2-r1)})
map_In19978=tm_shape(Indonesia) +
  tm_borders(col="white")+tm_shape(outputRaster) +tm_raster(palette =blups,
                                                            style = "fixed",title ="Indonesia(1997-1998)", breaks = c(-10, -3, 0, 3,12),
                                                            alpha = 0.9)+tm_legend(outside = TRUE, outside.position = c("right","bottom"))+tmap_options(max.raster 
                                                                                                                                                        = c(plot = 1030370, view = 1030370));map_In19978
