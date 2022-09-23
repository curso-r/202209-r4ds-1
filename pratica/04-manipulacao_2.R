options(scipen = 999)

# carregando pacotes
library(dplyr)
library(readr)
library(tidyr)

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

# funcao floor
# arredonda pra baixo
floor(2.1)
floor(2.9)

# funcao ceiling
ceiling(2.1)
ceiling(2.9)

# funcao round
round(2.1)
round(2.9)

# vendo qual filme teve a nota maxima pra cada decada

melhores_filmes_decada <- imdb |> 
  tidyr::drop_na(ano) |> 
  mutate(decada = floor(ano / 10) * 10,
         .after = ano) |> 
  group_by(decada) |> 
  filter(nota_imdb == max(nota_imdb)) |> 
  select(titulo, nota_imdb, decada) |> 
  arrange(decada)

# mostrando como funciona o ungroup

# quero calcular a media geral das notas:

# sem dar o ungroup isso nao funciona!

melhores_filmes_decada |> 
  summarise(nota_media = mean(nota_imdb))

# usando o ungroup:

melhores_filmes_decada |> 
  ungroup() |> 
  summarise(nota_media = mean(nota_imdb))

  
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
           .after = receita) |> 
  View()

# quero trazer receita, lucro e orcamento pro inicio da base

imdb |> 
  mutate(lucro = receita - orcamento) |> 
  relocate(lucro, orcamento, receita,
           .before = everything()) |> 
  View()


# paramos aqui ------------------------------------------------------------



# -------------------------------------------------------------------------

# Objetivo: descobrir qual o peso médio dos 
# personagens do Star Wars

# install.packages("dados")
library(dados)

View(dados_starwars)

# media do peso por sexo

dados_starwars |> 
  group_by(sexo_biologico) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# mostrar como substituir o NA por outra coisa

dados_starwars |> 
  mutate(
    sexo_biologico = if_else(is.na(sexo_biologico), 
                             "sem informacao", 
                             sexo_biologico)
  ) |> 
  group_by(sexo_biologico) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# segundo jeito

dados_starwars |> 
  mutate(
    sexo_biologico = replace_na(sexo_biologico, 
                                "sem informacao")
      ) |> 
  group_by(sexo_biologico) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# ouuuu podemos retirar os NA

dados_starwars |> 
  drop_na(sexo_biologico) |> 
  group_by(sexo_biologico) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# Peso por espécie

dados_starwars |> 
  drop_na(especie) |> 
  group_by(especie) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# Pegando as espécies mais pesadas

dados_starwars |> 
  drop_na(especie) |> 
  group_by(especie) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE)) |> 
  slice_max(order_by = peso_medio, n = 10)

# especies mais leves

dados_starwars |> 
  drop_na(especie) |> 
  group_by(especie) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE)) |> 
  slice_min(order_by = peso_medio, n = 5)

# Comparando com a altura

peso_altura <- dados_starwars |> 
  drop_na(especie) |> 
  group_by(especie) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE),
            altura_media = mean(altura, na.rm = TRUE)) |> 
  slice_max(order_by = peso_medio, n = 10) |> 
  ungroup()

# vamos fazer um grafico!

library(ggplot2)

peso_altura |> 
  ggplot() +
  geom_point(aes(x = peso_medio, y = altura_media))


# -------------------------------------------------------------------------

# Fazer exemplo que a Julia perguntou

# saber qual das duas sentenças é verdadeira

