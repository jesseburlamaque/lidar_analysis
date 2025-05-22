## 🌳 LiDAR Data Analysis in Tropical Forests

This repository contains a collection of R scripts for analyzing LiDAR data in the context of **tropical forest ecosystems**.

> This is a growing collection of personal scripts developed while working with LiDAR data in forest research.  
> I maintain this space as a **cookbook** — a place to store solutions, test ideas, and share tools with the community.

The focus is on key ecological and structural metrics, including:

- LAZ point cloud exploration and operations like clipping *(available)*  
- Vegetation structure and vertical profiles *(in progress)*  
- Dominant canopy height *(in progress)*  
- Individual tree segmentation *(coming soon)*  
- Above-ground biomass estimation *(coming soon)*  

The scripts are built primarily using the [`lidR`](https://cran.r-project.org/package=lidR) package in R.

If you're trying to make sense of millions of 3D points from the sky — this repository offers fast, reproducible workflows with `lidR`, `sf`, and a few 3D visualization tricks.

---

# ✨ What's Inside

### [LiDAR Point Cloud Visualization and Exploration](/r_scripts/00%20Explore%20LAZ.R)

Get an instant overview of your LiDAR data with:

- 2D colored-by-elevation plots for fast inspection  
- Fully interactive 3D scatter plots via `rgl` + `viridis`  
- Metadata and attribute previews for debugging or pre-processing  

> *Ideal for visually checking raw `.laz` files and understanding point distribution, classification, and intensity.*

---

### [Clip LAS File Using GeoJSON](/r_scripts/01%20Clip%20LAS%20File%20Using%20GeoJSON.R)

Trim your point cloud to your area of interest using vector geometries.

- Reads and reprojects GeoJSON polygons to match your LAS CRS  
- Clips the LAS file using `clip_roi()` from `lidR`  
- Saves and visualizes the cropped result for verification  

> *Great for spatial subsetting, site-specific analysis, and prepping data for downstream tasks.*

