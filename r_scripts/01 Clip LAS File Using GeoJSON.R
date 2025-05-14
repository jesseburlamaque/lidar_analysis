#Clip LAS File Using GeoJSON  
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
#' # Carregar pacotes necessários
library(lidR)
library(sf)

# Definir o caminho do arquivo LAS e do GeoJSON
LASfile <- "C:/Users/JesseBurlamaque/Documents/LIDAR/LiDAR/02.laz"
GeoJSONfile <- "C:/Users/JesseBurlamaque/Documents/LIDAR/lidR-processing/ROI's/02.geojson"

# Ler o arquivo LAS
las <- readLAS(LASfile)
if (is.null(las)) stop("Erro ao carregar o arquivo LAS. Verifique o caminho e o arquivo.")

# Definir o CRS do LAS como SIRGAS 2000 / UTM zone 20S (EPSG:31980)
crs_sirgas <- st_crs(31980)  # Define o CRS como EPSG:31980
crs(las) <- crs_sirgas       # Atribui o CRS ao arquivo LAS

# Carregar o GeoJSON como um objeto sf
sf_polygon <- st_read(GeoJSONfile)
if (is.null(sf_polygon)) stop("Erro ao carregar o GeoJSON. Verifique o caminho e o arquivo.")

# Certificar-se de que o CRS do polígono coincide com o CRS do LAS
sf_polygon <- st_transform(sf_polygon, st_crs(las))

# Cortar o arquivo LAS com o polígono do GeoJSON
las_cropped <- clip_roi(las, sf_polygon)

# Verificar se o recorte foi bem-sucedido
if (is.null(las_cropped)) stop("Nenhum ponto foi encontrado dentro do polígono.")

# Salvar o arquivo LAS recortado, se necessário
writeLAS(las_cropped, "C:/Users/JesseBurlamaque/Documents/LIDAR/LiDAR/croppped_laz/02_cropped.laz")

# Visualizar os pontos recortados
plot(las_cropped, bg = "white", size = 2)
