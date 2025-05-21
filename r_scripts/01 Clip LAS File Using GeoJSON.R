# Clip LAS File Using GeoJSON  
#'  
#' This script clips a `.laz` file using a polygon defined in a GeoJSON file.  
#' It utilizes the `lidR` package to process the `.laz` file and the `sf` package to handle the GeoJSON polygon.  
#' The script ensures that the coordinate reference system (CRS) of the GeoJSON matches the `.laz` file before performing the clipping.  
#'  
#' @param LASfile A character string representing the file path to the `.laz` LiDAR data file.  
#' @param GeoJSONfile A character string representing the file path to the GeoJSON polygon file.  
#'  
#' @details  
#' - The LAS file is read using the `readLAS` function from the `lidR` package.  
#' - The GeoJSON file is read as a spatial object using the `sf::st_read()` function.  
#' - The CRS of the GeoJSON polygon is transformed to match the CRS of the LAS file using `sf::st_transform()`.  
#' - The clipping operation is performed using the `clip_roi()` function, which extracts all LiDAR points within the polygon.  
#' - The clipped LAS can be saved as a new `.laz` file using the `writeLAS()` function.  
#'  
#' @return  
#' A LAS object containing only the points within the polygon defined in the GeoJSON file. The clipped LAS can also be saved to a new file if specified.  
#' 

# Load required packages
library(lidR)
library(sf)

# Define the path to the LAS file and the GeoJSON file
LASfile <- "C:/Users/JesseBurlamaque/Documents/LIDAR/LiDAR/02.laz"
GeoJSONfile <- "C:/Users/JesseBurlamaque/Documents/LIDAR/lidR-processing/ROI's/02.geojson"

# Read the LAS file
las <- readLAS(LASfile)
if (is.null(las)) stop("Error loading the LAS file. Check the path and the file.")

# Set the CRS of the LAS file to SIRGAS 2000 / UTM zone 20S (EPSG:31980)
crs_sirgas <- st_crs(31980)  # Set the CRS to EPSG:31980
crs(las) <- crs_sirgas       # Assign the CRS to the LAS file

# Load the GeoJSON as an sf object
sf_polygon <- st_read(GeoJSONfile)
if (is.null(sf_polygon)) stop("Error loading the GeoJSON. Check the path and the file.")

# Ensure the polygon's CRS matches the LAS CRS
sf_polygon <- st_transform(sf_polygon, st_crs(las))

# Clip the LAS file using the GeoJSON polygon
las_cropped <- clip_roi(las, sf_polygon)

# Check if the clipping was successful
if (is.null(las_cropped)) stop("No points were found within the polygon.")

# Save the clipped LAS file, if necessary
writeLAS(las_cropped, "C:/Users/JesseBurlamaque/Documents/LIDAR/LiDAR/croppped_laz/02_cropped.laz")

# Visualize the clipped points
plot(las_cropped, bg = "white", size = 2)
