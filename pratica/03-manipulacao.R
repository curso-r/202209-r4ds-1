# Objetivo: ler a base IMDB e gerar uma tabela
# com apenas as colunas filme e ano,
# ordenada por ano
# renomear as colunas
# e depois salvar em um arquivo excel

library(tidyverse)
library(readr)

# ler a base do imdb
imdb <- read_rds("dados/imdb.rds")

# obter colunas filme e ano
imdb_final <- imdb %>%
  select(titulo, ano) %>%
  # ordenar por ano
  arrange(desc(ano)) %>% 
  # renomear as colunas
  rename("Título do filme" = titulo, Ano = ano) # Pedido do Theo!
  
library(writexl)  

# # e depois salvar em um arquivo excel
write_xlsx(imdb_final, "dados-saida/imdb_final.xlsx")