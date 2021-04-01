#install.packages('googledrive')
#install.packages('rgee')
#library(rgee)
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