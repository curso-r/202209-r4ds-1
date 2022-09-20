options(scipen = 999)


# carregando pacotes
library(dplyr)
library(readr)

# lendo a base de dados
imdb <- read_rds("dados/imdb.rds")

# Objetivo: descobrir qual o filme mais caro, 
# mais lucrativo e com melhor nota dos anos 2000

# dentre os filmes de 2000 a 2009, qual o mais caro?
# ou seja, que teve maior orçamento

# filtrando os anos primeiro

imdb |> 
  filter(ano %in% 2000:2009)

# pergunta do carlos
imdb |> 
  filter(ano >= 2000 & ano <= 2009)

# usando o between
imdb |> 
  filter(between(ano, 2000, 2009))

# agora, vamos ver qual é o filme mais caro

imdb |> 
  filter(ano %in% 2000:2009,
         orcamento == max(orcamento))

# temos que tratar os NAs...

imdb |> 
  filter(ano %in% 2000:2009,
         orcamento == max(orcamento, na.rm = TRUE))

# filme que teve maior orcamento da base toda!

imdb |> 
  filter(
    orcamento == max(orcamento, na.rm = TRUE)
  ) |> 
  select(titulo, orcamento, ano)

# filme que teve maior orcamento entre 2000 e 2009

imdb |> 
  filter(ano %in% 2000:2009) |> 
  filter(
    orcamento == max(orcamento, na.rm = TRUE)
  ) |> 
  select(titulo, orcamento, ano)

# esse é o jeito correto! um filtro depois o outro

imdb |> 
  filter(ano %in% 2000:2009) |> 
  filter(orcamento == max(orcamento, na.rm = TRUE))

# como vamos usar isso mais vezes, vou criar um objeto
# só com os filmes dos anos 2000

imdb_2000 <- imdb |> 
  filter(ano %in% 2000:2009)

# qual o filme mais lucrativo dos anos 2000?

imdb_2000 |> 
  mutate(lucro = receita - orcamento) |> 
  filter(lucro == max(lucro, na.rm = TRUE)) |> 
  select(titulo, ano, lucro, receita, orcamento)


# qual filme com maior nota entre os filmes dos anos 2000?

imdb_2000 %>% 
  filter(nota_imdb == max(nota_imdb, na.rm = T)) |> 
  select(titulo, nota_imdb, ano, num_avaliacoes)

# filtrando por filmes que tiveram mais de 1000000 avaliacoes

imdb_2000 %>% 
  filter(num_avaliacoes > 10000) |> 
  filter(nota_imdb == max(nota_imdb, na.rm = T)) |> 
  select(titulo, nota_imdb, ano, num_avaliacoes)


## Fazendo para todas as décadas ##

# deixar para a proxima aula

# -------------------------------------------------------------------------

# Objetivo: pegar todos os filmes que sejam do genero "Comedy"

library(stringr)

# pegando todos os filmes que tenham o genero "Comedy"

imdb |> 
  filter(
    str_detect(generos, "Comedy")
  )

# fazendo filtro que funcione independende da maiusculo e minusculo

imdb |> 
  filter(
    str_detect(generos, regex("comedy", ignore_case = TRUE))
  ) |> 
  View()

# vendo como isso funciona, exemplo simples:

c("Comedy", "comedy", "Drama") |>
  str_detect(regex("comedy", ignore_case = TRUE))

# todos filmes que sejam de comedia e terror ao mesmo tempo

imdb |> 
  filter(
    str_detect(generos, "Comedy"),
    str_detect(generos, "Horror")
  ) |> View()

# todos filmes que sejam de comedia OU terror

imdb |> 
  filter(
    str_detect(generos, "Comedy") |
    str_detect(generos, "Horror")
  ) |> View()

# simplificando...

imdb |> 
  filter(
    str_detect(generos, "Comedy|Horror")
  ) |> View()

# quero filmes que nao sejam de comedia e nem de horror

imdb |> 
  filter(
    !str_detect(generos, "Comedy|Horror")
  ) |> 
  View()


# -------------------------------------------------------------------------


# Objetivo : mostrar relocate e rename ------

# funcao rename vai renomear uma coluna do jeito que a gente especificar

imdb_renomeado <- imdb |> 
  rename(
    nome_do_filme = titulo,
    ano_do_filme = ano
  )

# renomeando com o select

imdb |> 
  select(id_filme, nome_do_filme = titulo, 
         ano:num_criticas_critica)

# nao precisando especificar o nome de todas as colunas:

imdb |> 
  select(nome_do_filme = titulo, everything()) |> 
  View()

# relocate

# usando after

imdb |> 
  mutate(lucro = receita - orcamento) |> 
  relocate(lucro,
           .after = receita) |> View()

# quero trazer receita, lucro e orcamento pro inicio da base

imdb |> 
  mutate(lucro = receita - orcamento) |> 
  relocate(lucro, orcamento, receita,
           .before = everything()) |> View()


# paramos aqui ------------------------------------------------------------



# -------------------------------------------------------------------------

# Objetivo: descobrir qual o peso médio dos 
# personagens do Star Wars



# Peso por sexo

# mostrar como substituir o NA por outra coisa



# Peso por espécie



# Pegando as espécies mais pesadas



# Comparando com a altura



# -------------------------------------------------------------------------


# Objetivo: criar uma tabela sumarizando as produtoras, ordenadas por lucro.





# -------------------------------------------------------------------------

# Fazer exemplo que a Julia perguntou

# saber qual das duas sentenças é verdadeira


