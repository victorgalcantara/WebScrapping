# Title: raspagem de dados da internet - tabelas ALESP
# Author: Victor Gabriel Alcantara
# Date: 20.11.2021

# 0. Packages and setup -----------------------------------------------------

library(tidyverse)
library(rvest)    

wd <- "C:/Users/VictorGabriel/Documents/DADOS/"
setwd(wd)

# 1. Import databases --------------------------------------------------------
# Este é um exercício de extração de dados do site da ALESP. Trata-se da extração
# dos resultados da busca por projetos que contenham a palavra "Sociologia"
# url obtida: "https://www.al.sp.gov.br/alesp/pesquisa-proposicoes/?direction=inicio&lastPage=0&currentPage=0&act=detalhe&idDocumento=&rowsPerPage=20&currentPageDetalhe=1&tpDocumento=&method=search&text=sociologia&natureId=&legislativeNumber=&legislativeYear=&natureIdMainDoc=&anoDeExercicio=&strInitialDate=&strFinalDate=&author=&supporter=&politicalPartyId=&stageId="

# Na url obtida, alteramos a info da página para "NUMPAG" para extrair os dados

url_base <- "https://www.al.sp.gov.br/alesp/pesquisa-proposicoes/?direction=inicio&
  lastPage=0&
  currentPage=NUMPAG&
  act=detalhe&idDocumento=&rowsPerPage=20&
  currentPageDetalhe=1&tpDocumento=&method=search&text=sociologia&natureId=&
  legislativeNumber=&legislativeYear=&natureIdMainDoc=&anoDeExercicio=&
  strInitialDate=&strFinalDate=&author=&supporter=&politicalPartyId=&stageId="

o_que_procuro_para_susbtituir <- "NUMPAG"
o_que_quero_substituir_por <- 6

url <- gsub(o_que_procuro_para_susbtituir, o_que_quero_substituir_por, url_base)

url_base <- "https://www.al.sp.gov.br/alesp/pesquisa-proposicoes/?direction=inicio&lastPage=0&currentPage=NUMPAG&act=detalhe&idDocumento=&rowsPerPage=20&currentPageDetalhe=1&tpDocumento=&method=search&text=sociologia&natureId=&legislativeNumber=&legislativeYear=&natureIdMainDoc=&anoDeExercicio=&strInitialDate=&strFinalDate=&author=&supporter=&politicalPartyId=&stageId="

dados <- data.frame()

for (i in 0:18) {
  
  url <- gsub("NUMPAG", i, url_base)
  
  pagina <- read_html(url)
  
  lista_tabelas <- html_table(pagina, header = TRUE, fill = TRUE)
  
  tabela <- lista_tabelas[[1]]
  
  dados <- bind_rows(dados, tabela)
}

# 2. Data management -------------------------------------------------------

autores <- ifelse(dados$Autor != "---",dados$Autor,NA) %>% na.exclude()

fq <- table(autores)

fq_ordered <- sort(fq,decreasing = T)
top_10 <- head(fq_ordered,10)
