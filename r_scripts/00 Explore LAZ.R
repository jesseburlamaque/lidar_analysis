#' LiDAR Point Cloud Visualization and Exploration
#'
#' This script demonstrates basic LiDAR data exploration using the `lidR` package in R.  
#' It reads `.laz` files, inspects available point attributes, and produces 2D and 3D visualizations  
#' of the point cloud using height and intensity data.
#'
#' @details
#' - The script filters out ground-level noise using `-drop_z_below 0` during data loading.
#' - A preview and summary of the point cloud structure and metadata are provided.
#' - Visualization includes:
#'   - A 2D plot colored by height (Z)
#'   - A 3D scatter plot using the `rgl` and `viridis` packages for elevation-based coloring
#' - This script is intended for rapid visual inspection and attribute validation of LiDAR data before analysis.
#'
#' @requirements
#' - Input: A `.laz` file containing at least XYZ coordinates
#' - R packages: `lidR`, `rgl`, `viridis`
#'
#' @note
#' Adjust file paths and LASfile variables to match your directory structure.
#'
#' @author
#' Jessé Burlamaque

library(lidR)
library(rgl)

# 🧭 1. READING THE LAZ FILE WITH XYZ + INTENSITY

# Path to your LAZ file
LASfile1 <- "C:/Users/JesseBurlamaque/Downloads/lasfile01.laz"
LASfile2 <- "C:/Users/JesseBurlamaque/Downloads/lasfile01.laz"

# Read point cloud with XYZ, return number, and classification; filter out points below ground level
las <- readLAS(LASfile1, select = "xyzrc", filter = "-drop_z_below 0")

# Summarize point cloud structure
summary(las)

# EXPLORING AVAILABLE DATA ATTRIBUTES

names(las@data)   # List available attributes in the LAS file
npoints(las)      # Show number of points and basic metadata
head(las@data)    # Preview the first few points

# Visualize the point cloud:
plot(las, color = "Z", size = 2, bg = "white", axis = TRUE)

# 3D visualization colored by elevation (Z)

library(rgl)
library(viridis)

# Load the full point cloud with all attributes
las_full <- readLAS(LASfile1, select = "*")
names(las_full@data)  # Display column names for point attributes

# Color points by height using a viridis color scale
z_cols <- viridis(100)[findInterval(las_full@data$Z,
                                    seq(min(las_full@data$Z), max(las_full@data$Z), length.out = 100))]

# Plot the point cloud in 3D
plot3d(las_full@data$X, las_full@data$Y, las_full@data$Z,
       col = z_cols, size = 2,
       xlab = "X", ylab = "Y", zlab = "Z")
