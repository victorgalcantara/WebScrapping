# Title: raspagem de dados da internet - Folha de SP
# Author: Victor Gabriel Alcantara
# Date: 20.11.2021

# 0. Packages and setup -----------------------------------------------------

library(tidyverse)
library(rvest)    

wd <- "C:/Users/VictorGabriel/Documents/DADOS/"
setwd(wd)

# 1. Import databases --------------------------------------------------------
# url: "http://search.folha.uol.com.br/search?q=merenda&site=todos&results_count=3769&search_time=0.033&url=http%3A%2F%2Fsearch.folha.uol.com.br%2Fsearch%3Fq%3Dmerenda%26site%3Dtodos&sr=26"

url <- "http://search.folha.uol.com.br/search?q=merenda&site=todos&results_count=3769&search_time=0.033&url=http%3A%2F%2Fsearch.folha.uol.com.br%2Fsearch%3Fq%3Dmerenda%26site%3Dtodos&sr=26"
pagina <- read_html(url)

nodes_titulos <- html_nodes(pagina, xpath = "//a/h2/")