library(tidyverse)
library(sf)

fire <- st_read(".", layer = "Fire_Output")
rx_fire <- st_read(".", layer = "nonfire_rx_Output")
rx_nonfire <- st_read(".", layer = "nonfire_rx_Output")
