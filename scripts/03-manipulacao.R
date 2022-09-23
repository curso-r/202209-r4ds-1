# Pacotes -----------------------------------------------------------------

library(tidyverse)
library(dplyr)

# Base de dados -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")

# dúvida sobre tibble!
# read.csv retorna um data.frame simples
imdb_df <- read.csv("dados/imdb.csv")
imdb_df

# read_csv retorna um data.frame do tipo tibble
imdb_tibble <- read_csv("dados/imdb.csv")
imdb_tibble


# Jeito de ver a base -----------------------------------------------------

glimpse(imdb)
names(imdb)
View(imdb) # Cuidado com bases muito grandes!
head(imdb)

# dbl/numeric - números que aceitam casas decimais
# integer - números que não aceitam casas decimais


# dplyr: 6 verbos principais
# select()    # seleciona colunas do data.frame
# arrange()   # reordena as linhas do data.frame
# filter()    # filtra linhas do data.frame
# mutate()    # cria novas colunas no data.frame (ou atualiza as colunas existentes)
# summarise() + group_by() # sumariza o data.frame
# left_join   # junta dois data.frames

# select ------------------------------------------------------------------

# Selcionando uma coluna da base

select(imdb, titulo)

nome_dos_filmes <- select(imdb, titulo)

# A operação NÃO MODIFICA O OBJETO imdb

imdb

# Selecionando várias colunas

select(imdb, titulo, ano, orcamento)

1:5 # cria sequencia
10:100

select(imdb, titulo:generos)

# Funções auxiliares

select(imdb, starts_with("num"))

select(imdb, ends_with("cao"))

select(imdb, contains("cri"))



# Principais funções auxiliares

# starts_with(): para colunas que começam com um texto padrão
# ends_with(): para colunas que terminam com um texto padrão
# contains():  para colunas que contêm um texto padrão

# Selecionando colunas por exclusão

select(imdb, -titulo)

select(imdb, -c(titulo, ano, data_lancamento))

select(imdb, -titulo, -ano, -data_lancamento)

# podemos combinar várias regras!!
select(imdb, -starts_with("num"), -titulo, -ends_with("ao"))

# dúvida: e para linhas? 
# veremos na aula que vem! 
# exemplo:
View(filter(imdb, str_starts(titulo, "Avengers")))

# arrange -----------------------------------------------------------------

options(scipen = 999)

# Ordenando linhas de forma crescente de acordo com 
# os valores de uma coluna

arrange(imdb, orcamento)

# Agora de forma decrescente

arrange(imdb, desc(orcamento))


View(arrange(imdb, ano, nota_imdb))

# Ordenando de acordo com os valores 
# de duas colunas

View(arrange(imdb, desc(ano), orcamento))

# O que acontece com o NA? Sempre fica no final!
# NA = VALORES FALTANTES!


df <- tibble(x = c(NA, 2, 1), y = c(1, 2, 3))
arrange(df, x)
arrange(df, desc(x))




# pegar a base
# selecionar colunas: titulo, ano, nota
# ordenar as colunas ano e nota: primeiro filmes mais recentes, e filmes com nota maior (decrescente)
# filtrar filmes com mais de 10 mil avaliacoes


# forma 1) criando objetos intermediários
filmes_selecionados <- select(imdb, titulo, ano, nota_imdb, num_avaliacoes)

filmes_ordenados <- arrange(filmes_selecionados, desc(ano), desc(nota_imdb))

filmes_com_mais_avaliacoes <- filter(filmes_ordenados, num_avaliacoes > 10000)


# formar 2) funcoes aninhadas

filter(arrange(
  select(imdb, titulo, ano, nota_imdb, num_avaliacoes),
  desc(ano),
  desc(nota_imdb)
),
num_avaliacoes > 10000)

# 3) pipe - %>%  ou  |>
# criar sequencias de código!

imdb %>% 
  select(titulo, ano, nota_imdb, num_avaliacoes) %>% 
  arrange(desc(ano), desc(nota_imdb)) %>% 
  filter(num_avaliacoes > 10000)
  
  
# Command shift M  / 
  


  



# Pipe (%>%) --------------------------------------------------------------

# Transforma funçõe aninhadas em funções
# sequenciais

# g(f(x)) = x %>% f() %>% g()

x %>% f() %>% g()   # CERTO
x %>% f(x) %>% g(x) # ERRADO

# Receita de bolo sem pipe. 
# Tente entender o que é preciso fazer.

esfrie(
  asse(
    coloque(
      bata(
        acrescente(
          recipiente(
            rep(
              "farinha", 
              2
            ), 
            "água", "fermento", "leite", "óleo"
          ), 
          "farinha", até = "macio"
        ), 
        duração = "3min"
      ), 
      lugar = "forma", tipo = "grande", untada = TRUE
    ), 
    duração = "50min"
  ), 
  "geladeira", "20min"
)

# Veja como o código acima pode ser reescrito 
# utilizando-se o pipe. 
# Agora realmente se parece com uma receita de bolo.

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duração = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")

# ATALHO DO %>%: CTRL (command) + SHIFT + M

# versão 4.1
# pipe nativo do R - Atalho: CTRL SHIFT M 
imdb |> 
  select(titulo, ano, nota_imdb, num_avaliacoes) |> 
  arrange(desc(nota_imdb))

# pipe do tidyverse ou do Magrittr - Atalho: CTRL SHIFT M 
# para usar ele, precisamos carregar o tidyverse, ou magrittr
imdb %>% 
  select(titulo, ano, nota_imdb, num_avaliacoes) %>% 
  arrange(desc(nota_imdb))



# RELEMBRANDO  -------------------------------------------------------------------
# ctrl + shift + R para criar sessões

imdb <- read_rds("dados/imdb.rds")

# select

select(imdb, titulo, nota_imdb)

select(imdb, starts_with("num"))

select(imdb, -c(direcao:num_criticas_critica))

# arrange

arrange(imdb, ano)

arrange(imdb, desc(ano), desc(nota_imdb), desc(num_avaliacoes))

# pipe!!

# %>% - existe há anos!
  
# |> - de 2021!

imdb %>% 
  select(titulo)

select(imdb, titulo)

imdb %>% 
  select(titulo, nota_imdb, num_avaliacoes) %>% 
  arrange(desc(num_avaliacoes), desc(nota_imdb))

# filter ------------------------------------------------------------------

# filter() - filtrar linhas da base --------

# R é case sensitive: 'NOME' é diferente de 'nome'

# BEA bea bEa Bea beA 

# olhar as categorias de uma variável:


# Retorna uma tabela
imdb %>% 
  distinct(direcao) 

# Retorna um vetor
unique(imdb$direcao)

# Aqui falaremos de Conceitos importantes para filtros, 
# seguindo de exemplos!

## Comparações lógicas -------------------------------


# comparacao logica
# == significa: uma coisa é igual a outra?
x <- 1

# Teste com resultado verdadeiro
x == 1

# Teste com resultado falso
x == 2

# Exemplo com filtros!
# Filtrando uma coluna da base: O que for TRUE (verdadeiro)
# será mantido!

imdb %>% 
  filter(direcao == "Quentin Tarantino") %>%
  View()

imdb %>% 
  filter(direcao == "Quentin Tarantino", 
         producao == "Miramax") %>%
  View()




## Comparações lógicas -------------------------------

# maior 
x > 3
x > 0
# menor
x < 3
x < 0


x > 1
x >= 1 # # Maior ou igual
x < 1
x <= 1 # menor ou igual

# Exemplo com filtros!

## Recentes e com nota alta
imdb %>% filter(nota_imdb > 9, num_avaliacoes > 10000) %>% View()

imdb %>% filter(nota_imdb >= 9, num_avaliacoes >= 10000) %>% View()

imdb %>% filter(ano > 2010, nota_imdb > 8.5) %>% View()

imdb %>% filter(ano >= 2010, nota_imdb >= 8.5) %>% View()


## Gastaram menos de 100 mil, faturaram mais de 1 milhão
imdb %>% filter(orcamento < 100000, receita > 1000000) %>% View()

## Lucraram
imdb %>% filter(receita - orcamento > 0) %>% View()

# Outra forma:
imdb %>% 
  mutate(teve_lucro = receita - orcamento > 0) %>% 
  filter(teve_lucro == TRUE) %>% 
  View()

## Comparações lógicas -------------------------------

x != 2
x != 1

# Exemplo com filtros!
imdb %>% 
  filter(direcao != "Quentin Tarantino") %>% 
  View()

## Comparações lógicas -------------------------------

# operador %in% ( .... faz parte de ....?)
x %in% c(1, 2, 3)
x %in% c(2, 3, 4)

# Exemplo com filtros!

imdb %>% 
  filter(producao %in% c("Marvel Studios", "Marvel Entertainment",
                         "Marvel Productions", "Marvel Enterprises")) %>% View()


# O operador %in%

imdb %>% 
  filter(direcao %in% c('Matt Reeves', "Christopher Nolan")) %>% View()


imdb %>%
  filter(
    direcao %in% c(
      "Quentin Tarantino",
      "Christopher Nolan",
      "Matt Reeves",
      "Steven Spielberg",
      "Francis Ford Coppola"
    )
  ) %>% View()

# NÃO PODEMOS PULAR LINHA ANTES DO PIPE! apenas depois :)

# atalho CTRL SHIFT A para organizar código selecionado.

## Operadores lógicos -------------------------------
## operadores lógicos - &, | , !

## & - E - Para ser verdadeiro, os dois lados
# precisam resultar em TRUE
x <- 5

x >= 3 # TRUE
x <= 7 # TRUE

x >= 3 & x <= 7 # SÓ RETORNA VERDADEIRO SE OS DOIS LADOS
# FOREM VERDADEIROS (atender as duas condições)!

x >= 3 & x <= 4 # veerdadeiro com falso dá falso!

# no filter, a virgula funciona como o &
imdb %>%  
  filter(ano > 2010, nota_imdb > 8.5) %>%
  View()


imdb %>% 
  filter(ano > 2010 & nota_imdb > 8.5)


## Operadores lógicos -------------------------------

## | - OU - Para ser verdadeiro, apenas um dos
# lados precisa ser verdadeiro

# operador |


y <- 2
y >= 3
y <= 7

y >= 3 | y <= 7

y >= 3 | y <= 0

# Exemplo com filter

## Lucraram mais de 500 milhões OU têm nota muito alta
imdb %>% 
  filter(receita - orcamento > 500000000 | nota_imdb > 9) %>% 
  View()

# O que esse quer dizer?
imdb %>%
  filter(ano > 2010 | nota_imdb > 8.5) %>%
  View()



## Operadores lógicos -------------------------------

## ! - Negação - É o "contrário"

# operador de negação !
# é o contrario

!TRUE

!TRUE

!FALSE

# Exemplo com filter

imdb %>% 
  filter(!direcao %in% c("Quentin Tarantino",
                         "Christopher Nolan",
                         "Matt Reeves",
                         "Steven Spielberg",
                         "Francis Ford Coppola"
  )) %>%
  View()


## PAUSA - VAMOS PARA O SCRIPT 04-VALORES-ESPECIAIS
##  NA ---- 

# exemplo com NA
is.na(imdb$orcamento)

imdb %>% 
  filter(!is.na(orcamento))

# o filtro por padrão tira os NAs!
df <- tibble(x = c(1, 2, 3, NA))
df

filter(df, x > 1)

# manter os NAs!
filter(df, x > 1 | is.na(x))

# filtrar textos sem correspondência exata

textos <- c("a", "aa", "abc", "bc", "A", NA)
textos

library(stringr) # faz parte do tidyverse

str_detect(textos, pattern =  "a")

str_detect(textos, pattern = "ab")


## Pegando os seis primeiros valores da coluna "generos"
imdb$generos[1:6]

str_detect(
  string = imdb$generos[1:6],
  pattern = "Drama"
)

str_detect(
  string = imdb$generos[1:6],
  pattern = "Drama|Comedy" # | - expressão regular
)


## Pegando apenas os filmes que 
## tenham o gênero ação
imdb %>% filter(str_detect(generos, "Action")) %>% View()


# filtra generos que contenha filmes que tenha "Crime" no texto
imdb %>% 
  filter(str_detect(generos, "Crime")) %>% 
  View()

# filtra generos que seja IGUAL e APENAS "Crime"
imdb %>% filter(generos == "Crime") %>% View()


# duvida do Vinicius

imdb %>% 
  distinct(generos)


imdb %>% 
  tidyr::separate_rows(generos, sep = ", ") %>% 
  distinct(generos) %>% 
  View()


## RELEMBRANDO -----

library(tidyverse)

imdb <- read_rds("dados/imdb.rds")

# filmes com nota_imdb maior que 8, e mais de 100 críticas pelo público
imdb %>% 
  filter(nota_imdb > 8 & num_criticas_publico > 100)

imdb %>% 
  filter(nota_imdb > 8, num_criticas_publico > 100)


# filmes que, dentre os idiomas, tenha portugues
imdb %>% 
  filter(str_detect(idioma, "Portuguese")) %>%  View()


# filmes das seguintes produtoras:

# Marvel Productions
# Marvel Enterprises
# Marvel Studios
# Marvel Studios

imdb %>% 
  filter(str_starts(producao, "Marvel")) %>% View()

imdb %>%
  filter(
    producao %in% c(
      "Marvel Productions",
      "Marvel Enterprises",
      "Marvel Studios",
      "Marvel Entertainment"
    )
  ) %>% View()


# mutate ------------------------------------------------------------------

# Modificando uma coluna

imdb %>% 
  mutate(duracao = duracao/60) %>% 
  View()

# Criando uma nova coluna

imdb %>% 
  mutate(duracao_horas = duracao/60) %>% 
  View()


imdb %>% 
  mutate(duracao_horas = duracao/60, .after = duracao) %>% 
  View()



imdb %>% 
  mutate(lucro = receita - orcamento) %>% 
  View()

imdb %>% 
  mutate(lucro = receita - orcamento, .after = receita) %>% 
  View()

# A função ifelse é uma ótima ferramenta
# para fazermos classificação binária (2 CATEGORIAS)

imdb %>%
  mutate(lucro = receita - orcamento,
         houve_lucro = ifelse(lucro > 0, "Sim", "Não")) %>%
  View()

imdb %>%
  mutate(lucro = receita - orcamento,
         houve_lucro = ifelse(lucro > 0, "Sim", "Não"),
         .after = receita) %>%
  View()


# se X for verdade, faça isso ->>>>
#   se não, faça aquilo

# se a nota do filme for maior que 8.5, o filme é um sucesso,
# se não, o filme não é um sucesso


# classificacao com mais de 2 categorias:
# usar a função case_when()

imdb %>%
  mutate(
    categoria_nota = case_when(
      nota_imdb >= 8 ~ "Alta",
      nota_imdb < 8 & nota_imdb >= 5 ~ "Média",
      nota_imdb < 5 ~ "Baixa",
      TRUE ~ "Não classificado"
    ), .after = nota_imdb
  ) %>% View()

# summarise ---------------------------------------------------------------

# Sumarizando uma coluna

imdb %>% 
  summarise(media_orcamento = mean(orcamento, na.rm = TRUE))

# repare que a saída ainda é uma tibble


# Sumarizando várias colunas
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  media_receita = mean(receita, na.rm = TRUE),
  media_lucro = mean(receita - orcamento, na.rm = TRUE)
)

# Diversas sumarizações da mesma coluna
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  mediana_orcamento = median(orcamento, na.rm = TRUE),
  variancia_orcamento = var(orcamento, na.rm = TRUE),
  variancia_orcamento = var(orcamento, na.rm = TRUE),
  desvio_padrao_orcamento = sd(orcamento, na.rm = TRUE)
)

# Tabela descritiva
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  media_receita = mean(receita, na.rm = TRUE),
  qtd = n(),
  qtd_direcao = n_distinct(direcao),
  qtd_paises = n_distinct(pais)
)

imdb %>% 
  distinct(direcao) %>% 
  nrow()


# n_distinct() é similar à:
imdb %>% 
  distinct(direcao) %>% 
  nrow()


# funcoes que transformam -> N valores - FUNÇÕES BOAS PARA O MUTATE!
log(1:10)
sqrt(1:10)
str_detect()

# funcoes que sumarizam -> 1 valor - FUNÇÕES BOAS PARA SUMMARISE
sum(1:100)
mean(c(1, NA, 2))
mean(c(1, NA, 2), na.rm = TRUE)
n_distinct()
n()
knitr::combine_words()


# dúvida da vitória
imdb %>% 
  mutate(media_nota_imdb = mean(nota_imdb)) %>% View()
  

# group_by + summarise ----------------------------------------------------

# Agrupando a base por uma variável.

imdb %>% group_by(producao)

# Agrupando e sumarizando
imdb %>% 
  group_by(producao) %>% 
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    media_receita = mean(receita, na.rm = TRUE),
    qtd = n(),
    qtd_direcao = n_distinct(direcao)
  ) %>%
  arrange(desc(qtd)) %>% View()


# contar número de linhas por grupo
imdb %>% 
  group_by(direcao) %>% 
  summarise(n = n())

imdb %>% 
  count(direcao)

imdb %>% 
  count(direcao, sort = TRUE)
  

imdb %>% 
  group_by(direcao) %>% 
  summarise(n = n())

# dúvida do Theo
# tally - passando uma coluna como argumento, ele soma os valores da coluna
imdb %>% 
  group_by(direcao) %>% 
  tally(receita)

imdb %>%
  group_by(direcao) %>%  
  summarise(soma_receita = sum(receita, na.rm = TRUE))

  
# left join ---------------------------------------------------------------

# empilhamento bind_rows(x, y)
# join é outra coisa!

# dúvida da Flávia - comparar data frames
imdb_2 <- imdb %>% 
  relocate(orcamento, receita, .before = everything())

janitor::compare_df_cols(imdb, imdb_2)

waldo::compare(imdb, imdb_2)

# A função left join serve para juntarmos duas
# tabelas a partir de uma chave. 
# Vamos ver um exemplo bem simples.

band_members
band_instruments

band_members %>% 
  left_join(band_instruments)

band_instruments %>%
  left_join(band_members)

# o argumento 'by'
band_members %>%
  left_join(band_instruments, by = "name")

# OBS: existe uma família de joins

band_instruments %>%
  left_join(band_members)

band_instruments %>%
  inner_join(band_members)

band_instruments %>%
  full_join(band_members)

band_instruments %>%
  anti_join(band_members)

band_instruments %>%
  right_join(band_members)

# fuzzyjoin


# Um exemplo usando a outra base do imdb

imdb <- read_rds("dados/imdb.rds")
imdb_avaliacoes <- read_rds("dados/imdb_avaliacoes.rds")

imdb %>% 
  #left_join(imdb_avaliacoes, by = "id_filme") %>%
  left_join(imdb_avaliacoes) %>%
  View()


imdb %>% 
  select(id_filme, titulo) %>% 
  left_join(imdb_avaliacoes) %>% 
  View()
