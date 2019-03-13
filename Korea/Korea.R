
# extract korea shapefile
tmap_mode('view')
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
