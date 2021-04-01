#install.packages('googledrive')
#install.packages('rgee')
library(rgee)
#install.packages("geojsonio")
#install.packages("sfheaders")
#Sys.which('make')
#ee_install()
#ee_Initialize('Mario caceres')

col <- ee$ImageCollection("COPERNICUS/S2_SR")
point <- ee$Geometry$Point(-71.6002957, -33.0055093)
start <- ee$Date("2020-02-11")
end <- ee$Date("2020-02-20")
filter <- col$filterBounds(point)$filterDate(start, end)
img <- filter$first()

vPar <- list(bands = c("B4", "B3", "B2"), min = 100, max = 8000, 
             gamma = c(1.9, 1.7, 1.7))
Map$setCenter(-71.6002957, -33.0055093, zoom = 10)
Map$addLayer(img, vPar, "Color real")

getNDVI <- function(image) {
  return(image$normalizedDifference(c("B8", "B4")))
}
ndvi1 <- getNDVI(img)
ndviPar <- list(palette = c("#cccccc", "#f46d43", "#fdae61", 
                            "#fee08b", "#d9ef8b", "#a6d96a", "#66bd63", "#1a9850"), min = 0, 
                max = 1)

Map$setCenter(-71.6002957, -33.0055093, zoom = 10)
Map$addLayer(ndvi1, ndviPar, "NDVI verano")



library(raster)
library(sf)
library(tidyverse)
ee_x <- st_read(system.file("shape/nc.shp", package = "sf"))
ValpoVina <- getData("GADM", country = "CHL", level = 2) %>% 
  st_as_sf() %>% dplyr::filter(NAME_1 == "Valparaíso", NAME_2 %in% 
                                 c("Valparaíso")) %>% st_transform(st_crs(ee_x)) %>% sf_as_ee()

