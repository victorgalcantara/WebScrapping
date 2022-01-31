# Title: WebScrapping - Artigos Rev. RBCS
# Author: Victor Gabriel Alcantara
# Date: 20.11.2021

# 0. Packages and setup -----------------------------------------------------

library(tidyverse)
library(rvest)    

wd <- "C:/Users/VictorGabriel/Documents/DADOS/REV_EST_AVALIACAO/"
setwd(wd)

# 1. Import databases --------------------------------------------------------
# url: "http://publicacoes.fcc.org.br/index.php/eae/issue/archive"  
url <- "http://anpocs.org/index.php/publicacoes-sp-2056165036/rbcs?limitstart=0"

# Lendo o documento html
links <- read_html(url) %>% 
  html_nodes(xpath = "//h1[@class='title']/a") %>%
  html_attr(name = "href")

# página da Revista n
tag_a_link_art <- read_html(paste0("http://anpocs.org",links_nrev[1]) ) %>% 
                  html_nodes(xpath = "//a")

text  <- html_text(tag_a_link_art, trim = T)  %>% str_replace_all(.,c("/"),"")
links <- text == "pdf"

links_art <- html_attr(tag_a_link_art[links], name = "href")

# PAREI AQUI
# Problema: não sei como baixar o arquivo .pdf contido na página.