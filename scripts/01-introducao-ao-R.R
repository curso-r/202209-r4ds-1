# Rodando códigos (o R como calculadora) ----------------------------------

# ATALHO para rodar o código: CTRL + ENTER

# adição
1 + 1

# subtração
4 - 2

# multiplicação
2 * 3

# divisão
5 / 3

# potência
4 ^ 2

# Objetos -----------------------------------------------------------------

# As bases de dados serão o nosso objeto de trabalho 
mtcars

# O objeto mtcars já vem com a instalação do R
# Ele está sempre disponível

# Outros exemplos 
pi
letters
LETTERS

# Na prática, vamos precisar trazer nossas bases
# para dentro do R. Como faremos isso?

# Funções -----------------------------------------------------------------

# Funções são nomes que guardam um código de R. Esse código é
# avaliado quando rodamos uma função.

nrow(mtcars) # número de linhas - row = linha
ncol(mtcars) # número de colunas - col = coluna

# Podemos usar a função help para ver
# a documentação de um objeto ou função
help(mtcars)
help(nrow)

# Uma função muito útil para data frames é a View
View(mtcars)

# Uma função pode ter mais de um argumento
# Argumentos são sempre separados por vírgulas

sum(1, 2)
sum(2, 3, 4)

c(1, 2)
sum(c(1,2))

# Existem funções para ler bases de dados

read.csv("dados/imdb.csv")

# CSV - Comma Separated Value - arquivo de texto
# valores separados por vírgula, ou ponto e vírgula (;).

# Como "salvar" a base dentro do R?

# Criando objetos ---------------------------------------------------------

# No dia-a-dia, a gente vai precisar criar os 
# nossos próprios objetos

# chamamos de atribuição: <-


# Salvando o valor 1 no objeto "obj"
obj <- 1
obj

# Também dizemos 'guardando as saídas'
soma <- 2 + 2
soma

# ATALHO para a <- : ALT - (alt menos)

# Em geral, começaremos a nossa análise com:
nossa_base <- funcao_que_carrega_uma_base("caminho/ate/arquivo")

# O erro "could not find function" significa que 
# você pediu para o R avaliar uma função que
# não existe. O mesmo vale para objetos:

nossa_base

# Dicas:
# - sempre leia as mensagens de erro
# - verifique no Environment se um objeto existe

# No nosso caso:
imdb <- read.csv("dados/imdb.csv")

# salvar saída versus apenas executar
33 / 11
resultado <- 33 / 11

# atualizar um objeto
resultado <- resultado * 5

# imdb <- 1

# A nossa base imdb só será alterada quando salvarmos
# uma operação em cima do objeto imdb

na.exclude(imdb)
imdb_sem_na <- na.exclude(imdb)

# Os nomes devem começar com uma letra.
# Podem conter letras, números, _ e .

# Permitido

x <- 1
x1 <- 2
objeto <- 3
meu_objeto <- 4
meu.objeto <- 5

# Não permitido

1x <- 1
_objeto <- 2
meu-objeto <- 3

# Estilo de nomes

eu_uso_snake_case
outrasPessoasUsamCamelCase
algumas.pessoas.usam.pontos.mas.nao.deviam
E_algumasPoucas.Pessoas_RENUNCIAMconvenções

# comentário

View(imdb) # ver a base imdb

# checkpoint --------------------------------------------------------------

# 1. Apague os objetos criados na aba environment, clicando na  vassoura!

# 2. Escrevam (não copiem e colem) o código que lê a base e 
# a salva num objeto imdb. Rodem o código e observem 
# na aba environment se o objeto imdb apareceu.

imdb <- read.csv("dados/imdb.csv")
View(imdb)


# Classes -----------------------------------------------------------------

imdb

# Cada coluna da base representa uma variável
# Cada variável pode ser de um tipo (classe) diferente

# Podemos somar dois números
1 + 2

# Não podemos somar duas letras (texto)
"a" + "b"

##############################
# Use aspas para criar texto #
##############################

a <- 10

# O objeto a, sem aspas
a

# A letra (texto) a, com aspas
"a"

# Numéricos (numeric)

a <- 10
class(a)

# Caracteres (character, strings)

obj <- "a"
obj2 <- "masculino"

class(obj)
class(obj2)

# lógicos (logical, booleanos)

verdadeiro <- TRUE # VALE 1
falso <- FALSE # VALE 0

class(verdadeiro)
class(falso)

TRUE + TRUE

FALSE + FALSE

# dúvida da Monyze: vamos ver na aula de filtros!
TRUE == FALSE


# Data frames - TABELAS!
# tem linhas e colunas
# tibble, base de dados, dados tabulares

class(mtcars)
class(imdb)

imdb$data_lancamento
class(imdb$data_lancamento)

class(as.Date("2001-01-01"))

# quantos filmes foram lançados a partir de 01/01/2001?
sum(as.Date(imdb$data_lancamento) >= as.Date("2001-01-01"), na.rm = TRUE)

# o filme mais recente é de 2021
max(as.Date(imdb$data_lancamento), na.rm = TRUE)

# Como acessar as colunas de uma base?
imdb$data_lancamento

# Como vemos a classe de uma coluna?
class(imdb$data_lancamento)

imdb$data_lancamento # chamei de conjunto mas o termo é VETOR

# remover objetos do environment
rm(a)
rm(falso)
rm(obj)

# Vetores -----------------------------------------------------------------

# Vetores são conjuntos de valores: use a função c()

vetor1 <- c(1, 4, 3, 10)
vetor2 <- c("a", "b", "z")

vetor1
vetor2

# Uma maneira fácil de criar um vetor com uma sequência de números
# é utilizar o operador `:`

# Vetor de 1 a 10
1:10

# Vetor de 10 a 1
10:1

# Vetor de -3 a 3
-3:3

1:nrow(imdb)

# As colunas de data.frames são vetores
mtcars$mpg
titulo_filmes <- imdb$titulo

class(mtcars$mpg)
class(imdb$titulo)

# O operador $ pode ser utilizado para selecionar
# uma coluna da base

# Um vetor só pode guardar um tipo de objeto e ele terá sempre
# a mesma classe dos objetos que guarda

vetor1 <- c(1, 5, 3, -10)
vetor2 <- c("a", "b", "c")

class(vetor1)
class(vetor2)

# Se tentarmos misturar duas classes, o R vai apresentar o
# comportamento conhecido como coerção

vetor <- c(1, 2, "a")

vetor
class(vetor)

# character > numeric > integer > logical

class(1L) # integer é numero inteiro
class(1)
class(1.2) # double e numeric - aceita casas demais

# coerções forçadas por você
as.numeric(c(TRUE, FALSE, FALSE))
as.character(c(TRUE, FALSE, FALSE))

class("2022-09-12")
class(as.Date("2022-09-12"))
as.logical("TRUE")

mean(mtcars$mpg)

# Por consquência, cada coluna de uma base 
# guarda valores de apenas uma classe.

# Naturalmente, podemos fazer operações matemáticas com vetores

vetor <- c(0, 5, 20, -3)

vetor + 1
vetor - 1
vetor / 2
vetor * 10


# Você também pode fazer operações que envolvem mais de um vetor:

vetor1 <- c(1, 2, 3)
vetor2 <- c(10, 20, 30)

vetor1  + vetor2

# Pacotes -----------------------------------------------------------------

# colecao de: funcoes, documentação, bases de dados
# tem algum foco

# Para instalar pacotes
install.packages("tidyverse")
# Para usar os pacotes
library(tidyverse)
library(dplyr)
# quando reiniciar o R,  os pacotes sao descarregados.



# Também é possível acessar as funções usando ::
dplyr::filter_at()
dplyr::transmute()

# olhar a base
dplyr::glimpse(imdb)

# Pergunta Julia
# install.packages("skimr")
skimr::skim(imdb)

summary(imdb)


# Duvida Flavia
# mostrar como criar uma coluna multiplicando valores dre uma coluna 
# que existe na base

imdb_2 <- mutate(imdb, duracao_horas = duracao/60)
