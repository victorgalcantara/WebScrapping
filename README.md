## Web scrapping with R

Raspagem de dados da web com o pacote "rvers" no R, um dos pacotes que compõem o universo tydiverse, um projeto do Rstudio de reescrever a linguagem R e torná-la mais intuitiva e usual.

Estes scripts são aplicações do curso de web scrapping oferecido na UFMG pelos professores Denisson Silva e Rogério Jerônimo Barbosa ([disponível aqui](https://github.com/antrologos/mq_2018_WebScraping)).

# 00 Tabelas em uma página web - ALESP

O primeiro código trata-se do estudo de raspagem dados em tabelas numa página web. Neste caso utilizamos as seguintes funções e lógicas de programação:

read_html( url ) : lê documentos html publicados na web. O resultado é um documento em formato XML, com o código html da página (o qual podemos inspecionar usando o navegador).

html_table(pagina, header = TRUE, fill = TRUE) : lê tabelas numa página html.
"header = TRUE": serve para indicarmos ao nosso "extrator de tabelas HTML" que a primeira linha da tabela deve ser considerada cabeçalho (nome das colunas)
"fill = TRUE"diz para que o R preencha (com espaços vazios) partes da tabela que podem estar incompletas (como, por exemplo, linhas com números desiguais de colunas etc.)

# 01 Arquivos guardados em uma página (localização, download e armazenamento em disco) - artigos da revista acadêmica Estudos em Avaliação

html_nodes(pagina, xpath = "//caminho_XML") : lê tags especificadas pelo caminho XML de uma página HTML

html_attr(tag, name = "atributo") : lê conteúdo dentro de um atributo da tag

html_text(tag, trim = "TRUE") : lê textos dentro de uma tag

download.file(url, # link do arquivo a ser baixado
              "caminho.ext", # caminho do arquivo com a extensão
              mode = "wb") # modo/estrutura binária

dir.create("caminho") : do R base, cria pastas no diretório especificado (quando não especificado, o R assume o de trabalho - WD)
write.csv(objeto, "caminho") : salva objeto da memória em estrutura CSV

