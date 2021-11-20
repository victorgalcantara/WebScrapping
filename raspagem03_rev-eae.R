# Title: raspagem de dados da internet - tabelas
# Author: Victor Gabriel Alcantara
# Date: 20.11.2021

# 0. Packages and setup -----------------------------------------------------

library(tidyverse)
library(rvest)    

wd <- "C:/Users/VictorGabriel/Documents/DADOS/REV_EST_AVALIACAO/"
setwd(wd)

# 1. Import databases --------------------------------------------------------
# url: "http://publicacoes.fcc.org.br/index.php/eae/issue/archive"  
url <- "http://publicacoes.fcc.org.br/index.php/eae/issue/archive"

# Lendo o documento html
pagina <- read_html(url)

# navegando no documento: extraindo as tags "a" com class='cover'
tag_a_edicoes   <- html_nodes(pagina, xpath = "//a[@class='title']")
tag_div_edicoes <- html_nodes(pagina, xpath = "//div[@class='series']")

# extraindo das tags selecionadas os links no atributo "href"
links_edicoes <- html_attr(tag_a_edicoes, name = "href")

# textos com descr das edicoes
text_edicoes  <- html_text(tag_a_edicoes, trim = T)  %>% str_replace_all(.,c("/"),"")
text_edicoes2 <- html_text(tag_div_edicoes,trim = T) %>% str_replace_all(.,c("/"),"")

text_edicoes       <- text_edicoes[-11]
text_edicoes[2:23] <- text_edicoes2[1:22]

for(i in 13:30){ 

# Edicoes da revista I -------

# lendo o doc html da revista edicao x
ed_x <- read_html(links_edicoes[i])

# navegando no documento: extraindo as tags "a" com class='cover'
tag_a_ed_x  <- html_nodes(ed_x, xpath = "//h3[@class='title']/a")

# extraindo das tags selecionadas os links no atributo "href"
links_artigos <- html_attr(tag_a_ed_x, name = "href")

titulos<- html_text(tag_a_ed_x,trim = T) # extrai o texto na tag, no caso o título do art

link_artigo <- rep("",length(links_artigos))

for(j in 1:length(links_artigos)) { # Artigos J --------------------
print(j)
# pag de descrição do art
page_descricao_artigo <- read_html(links_artigos[j])

# localizando a tag <a> </a> com o link para a pag do artigo
tag_a_art  <- html_nodes(page_descricao_artigo, xpath = "//a[@class='obj_galley_link pdf']")
# link da pag do artigo
link_page_artigo <- html_attr(tag_a_art, name = "href")

# pag do artigo
page_artigo <- read_html(link_page_artigo[1])
# tag download
tag <- html_nodes(page_artigo, xpath = "//a[@class='download']")
# link do download
link_artigo[j] <- html_attr(tag[1], name = "href")
}

dir.create(text_edicoes[i])

artigos <- data.frame("id"=c(1:length(links_artigos)),"titulo"=titulos,"link-download"=link_artigo,
                      "link-artigo"=links_artigos)
write.csv(artigos,paste0(text_edicoes[i],"/catalogo"))
# 2. Data management -------------------------------------------------------

for(j in 1:length(link_artigo)){
download.file(link_artigo[j], 
              paste0(text_edicoes[i],"/",j,".pdf"), # caminho do arquivo
              mode = "wb")}
}
