library(tidyverse)

# Caminhos até o arquivo --------------------------------------------------

# Caminho absoluto
"~/Desktop/material_do_curso/dados/imdb.csv"

# Caminhos absolutos - Não é uma boa prática
"/home/william/Documents/Curso-R/main-r4ds-1/dados/imdb.csv"

# Caminhos relativos
"dados/imdb.csv"

"dados/imdb.csv"

# (cara(o) professora(o), favor lembrar de falar da dica 
# de navegação entre as aspas - CLICANDO TAB)

"./" # relativo, 

"../" # sobe um nível nas pastas - relativo

"/" # raiz do computador


# Tibbles -----------------------------------------------------------------

airquality

class(airquality)

as_tibble(airquality) # coercao de data frame pra tibble

class(as_tibble(airquality))

# Lendo arquivos de texto -------------------------------------------------

# CSV, separado por vírgula
imdb_csv <- read_csv("dados/imdb.csv")

imdb_csv

# R$ 1000,00 # como usamos no BR
# U$ 1000.00 # como o R usa

# CSV, separado por ponto-e-vírgula
imdb_csv2 <- read_csv2("dados/imdb2.csv")

# TXT, separado por tabulação (tecla TAB)
imdb_txt <- read_delim("dados/imdb.txt", delim = "\t")

# A função read_delim funciona para qualquer tipo de separador
imdb_delim <- read_delim("dados/imdb.csv", delim = ",")
imdb_delim2 <- read_delim("dados/imdb2.csv", delim = ";")

# direto da internet
imdb_csv_url <- read_csv("https://raw.githubusercontent.com/curso-r/main-r4ds-1/master/dados/imdb.csv")


# Interface point and click do RStudio também é útil!


imdb2 <- read_delim("dados/imdb2.csv", delim = ";", 
                    escape_double = FALSE, trim_ws = TRUE)
View(imdb2)

# Lendo arquivos do Excel -------------------------------------------------

library(readxl)

imdb_excel <- read_excel("dados/imdb.xlsx")

excel_sheets("dados/imdb.xlsx")

imdb_excel <- read_excel("dados/imdb.xlsx", sheet = "Sheet1")


# imdb nao estruturada
excel_sheets("dados/imdb_nao_estruturada.xlsx")

sheet1 <- read_excel("dados/imdb_nao_estruturada.xlsx", sheet = "Sheet1")
sheet2 <- read_excel("dados/imdb_nao_estruturada.xlsx", sheet = "Sheet2")

# Salvando dados ----------------------------------------------------------

imdb <- read_csv2("dados/imdb2.csv")

filmes_nota_maior <- filter(imdb, nota_imdb > 5)

write_csv(filmes_nota_maior, "filmes_nota_maior_5.csv")
write_csv2(filmes_nota_maior, "filmes_nota_maior_5_2.csv")

# As funções iniciam com 'write'

# imdb <- imdb_csv

# CSV
write_csv(imdb, file = "dados-saida/imdb.csv")

# Excel
# install.packages("writexl")
library(writexl)
write_xlsx(imdb, path = "imdb.xlsx")

dir.create("dados-saida") # criar a pasta dados-saidas

write_xlsx(filmes_nota_maior, "dados-saida/filmes_nota_maior_excel.xlsx")


# O formato rds -----------------------------------------------------------

# .rds são arquivos binários do R
# Você pode salvar qualquer objeto do R em formato .rds

imdb_rds <- read_rds("dados/imdb.rds")
write_rds(imdb_rds, file = "dados-saida/imdb_rds.rds")

# escolaridade

# leitura rápida
leitura_com_vroom <- vroom::vroom("dados/imdb.csv")

