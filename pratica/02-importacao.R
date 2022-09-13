library(vroom)
library(dplyr)
library(janitor)
# Importar usando o link em CSV!
arquivo_csv <- "http://orcamento.sf.prefeitura.sp.gov.br/orcamento/uploads/2022/basedadosexecucao2022_0822.csv"

guess_encoding(arquivo_csv)

# # A tibble: 2 × 2
# encoding   confidence
# <chr>           <dbl>
# 1 ISO-8859-1       0.71
# 2 ISO-8859-2       0.26

execucao_pref <- read_csv2(arquivo_csv,
                       locale = locale(encoding = "ISO-8859-1"))

?read_csv()

# Rows: 5267 Columns: 48                                                                                                
# ── Column specification ────────────────────────────────────────────────────────────────────────────────────────────────
# Delimiter: ";"
# chr (25): DataInicial, DataFinal, Administracao, Cd_Orgao, Sigla_Orgao, Ds_Orgao, Ds_Unidade, Cd_Funcao, Ds_Funcao, ...
# dbl (11): Cd_AnoExecucao, Cd_Exercicio, Cd_Unidade, Cd_Despesa, Categoria_Despesa, Grupo_Despesa, Cd_Modalidade, Cd_...
# 
# ℹ Use `spec()` to retrieve the full column specification for this data.
# ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.


glimpse(execucao_pref)

execucao_pref_2 <- clean_names(execucao_pref)

glimpse(execucao_pref_2)


# Ler do excel:

library(readxl)
url <- "http://orcamento.sf.prefeitura.sp.gov.br/orcamento/uploads/2022/basedadosexecucao2022_0822.xlsx"
destfile <- "basedadosexecucao2022_0822.xlsx"
curl::curl_download(url, destfile)
base <- read_excel(destfile)
View(base)
