# LabMet2 - CP084-A - Metodologias de Pesquisa em Ciência Política II
#
# Referências: 
#   - https://r4ds.had.co.nz/
#   - https://rstudio-education.github.io/hopr/
#   - https://ggplot2.tidyverse.org/
#   - https://dplyr.tidyverse.org/
#
# Introdução aula R

# limpa o ambiente
rm(list = ls())

# diretório atual
getwd()

# define diretório de trabalho
setwd()

# instala pacotes
install.packages("knitr")
install.packages("nycflights13")
install.packages('dplyr', repos = 'https://cloud.r-project.org')
install.packages('ggplot2')

# verifica versão do R
version

# carrega pacotes instalados
library(dplyr)
library(knitr)
library(nycflights13)
library(ggplot2)

# contas 
1+3

# armazena dados
quatro <- 3 +1
# vê
quatro
# armazena objeto de texto
oi <- "olá"

# modificar o valor do objeto
oi <- "olá, tudo bem com vossa senhoria?"
oi

# raiz quadrada
sqrt(4)

# ler csv
star <- read.csv("STAR.csv")
bes <- read.csv("BES.csv")
# ver dados
View(bes)
View(star)

# ver estrutura dos dados
str(bes)
str(star)

# verificar a dimensão dos dados
dim(bes)
dim(star)

# ver as primeiras linhas
head(bes)
head(star)

# verifica a classe das variáveis star
class(star$classtype)
class(star$reading)
class(star$math)
class(star$graduated)

# Visualizar valores das variáveis
star$reading

# calcula a média de uma variável
mean(star$reading)
mean(star$math)
mean(star$graduated)

# Operações relacionais 
3 == 3
3 != 4
3 > 4
star$classtype == "small"

# consulta valores de variáveis
ifelse(star$classtype == "small", 1, 0)

# cria nova variável com novos valores 0 e 1 
star$small <- ifelse(star$classtype == "small", 1, 0)

# ver as primeiras linhas
head(star)

# calcula média apenas para um subgrupo (apenas quando small for true u small false)
mean(star$reading[star$small == 1])
mean(star$reading[star$small == 0])

# calcula a diferença entre média dos dois grupos
mean(star$math[star$small == 1]) - mean(star$math[star$small == 0])

# Parte 2 com bibliotecas
# ver os dados do pacote nycflights13
# ver os dados flights
flights
View(flights)
# glimpse = visão geral
glimpse(flights)


airlines
kable(airlines)

airlines$name

?flights

# permite visualizar a relação entre das variáveis numéricas

# prática: relação em dep_delay (x) e arr_delay (y) de Alaska Airlines
# filtra voos da alaska airlines
alaska_flights <- flights %>%
  filter(carrier == "AS")
# ver dados
View(alaska_flights)

# plota gráfico de dispersão # dep = departure & arr = arrived 
# informa que o gráfico é de pontos
ggplot(data = alaska_flights) +
  geom_point(mapping = aes(x = dep_delay, y = arr_delay)) 
# outra forma de escrever o mesmo código
ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_point()

# repete o gráfico aplicando jitter
ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_jitter(width = 50, height = 50)

# relação entre duas variáveis, quando a variável do eixo x é ordinal
# visualiza o banco weather
glimpse(weather)

# filtra dados de temperatura do aeroporto de Newark nos primeiros 15 dias de janeiro
early_january_weather <- weather %>%
  filter(origin == "EWR" & month == 1 & day <= 15)
View(early_january_weather)

# faz o gráfico de linha (label)
ggplot(data = early_january_weather, mapping = aes(x = time_hour, y = temp)) +
  geom_line()

# Plota frequência de valor numérico de variável
# faz o histograma
ggplot(data = weather, mapping = aes(x = temp)) + 
  geom_histogram()
# faz o histograma separando as barras
ggplot(data = weather, mapping = aes(x = temp)) + 
  geom_histogram(color = "white")
# faz o histograma com as barras com preenchimento azul
ggplot(data = weather, mapping = aes(x = temp)) + 
  geom_histogram(color = "white", fill = "blue")
# faz o histograma com mais barras (padrão = 30)
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(bins = 50, color = "white", fill = "blue")
# faz o histograma com mmenos barras
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(bins = 10, color = "white", fill = "blue")

# facetas: quando queremos dividir a visualização de acordo com outra variável
# faz o gráfico com facet por mês
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month)
# repete i fráfico especificando o numero de linhas para a distrivuição das facetas
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month, nrow = 4)

# boxplot
# informam sobre 5 valores de variáveis quantitativa (minimo, 25%, 50% 75% e máximo
# tenta fazer o boxplot de temperaturas por mês, mas mensagem de erro avisa que
#variável no x precisa ser categórica, faz mas da errado
ggplot(data = weather, mapping = aes(x = month, y = temp)) +
  geom_boxplot()
# converte variável month em fator (categórica)
ggplot(data = weather, mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot()

# barplots
#distribuição de variável numérica ou fraquência de variável categórica
# cria banco de dados com frutas
fruit <- tibble(
  fruit = c("apple", "apple", "orange", "apple", "orange")
)

# cria novo banco de dados tendo contado as frutas
fruit_counted <- tibble(
  fruit = c("apple", "orange"),
  number = c(3, 2)
)

# barplot cria gráfico de barras com o banco de frutas
ggplot(data = fruit, mapping = aes(x = fruit)) +
  geom_bar()

# cria gráfico com banco de dados contado
ggplot(data = fruit_counted, mapping = aes(x = fruit, y = number)) +
  geom_col()

# faz o gráfico com variável cateória (companhia)
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar()

# gráfico de pizza
# contagem de carriers
carriers_count <- flights %>%
  count(carrier)

# gráfico de pizza
ggplot(carriers_count, aes(x = "", y = n, fill = carrier)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  scale_fill_grey(start = 0.3, end = 0.8) +
  theme_void()

# muda cores para colorido
ggplot(carriers_count, aes(x = "", y = n, fill = carrier)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void()

# adiciona rótulos
ggplot(carriers_count, aes(x = "", y = n, fill = carrier)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(label = n), position = position_stack(vjust = 0.5))

# adiciona título
ggplot(carriers_count, aes(x = "", y = n, fill = carrier)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(label = n), position = position_stack(vjust = 0.
5)) +
  ggtitle("Número de voos por companhia aérea em 2013")

# Agrupa bancos de dados por variável em comum
flights_joined <- flights %>%
  inner_join(airlines, by = "carrier")
View(flights)
View(flights_joined)
  
# agrupa banco de dados, com nomes diferentes para a mesma variável - em jm banco
# está escrito de uma forma, no outro de outra forma, considerando elas como uma só
flights_with_airport_names <- flights %>%
  inner_join(airports,  by = c("dest" = "faa"))
View(flights_with_airport_names)

# cria banco unindo várias variáveis em comum
flights_weather_joined <- flights %>%
  inner_join(weather, by = c("year", "month", "day", "hour", "origin"))
View(flights_weather_joined)

# seleciona variáveis específicas
flights %>%
  select(carrier, flight)

# remove variáveis específicas
flights_no_year <- flights %>% select(-year)

# reordenar collunas no banco de dados
flights_reordered <- flights %>%
  select(year, month, day, hour, minute, origin, dest, everything())
View(flights_reordered)

# outras formas de selecionae variável
flights %>% select(starts_with("a"))
flights %>% select(ends_with("y"))
flights %>% select(contains("time"))

# conta número de voos por destino
flights %>%
  count(dest) %>%
  arrange(desc(n)) 

# cria banco com nome dos destinos
named_dests <- flights %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  select(dest, name) %>%
  group_by(dest, name) %>%
  summarise(num_flights = n())
View(named_dests)

# ver top 10 de destinos com mais voos
named_dests %>%
  top_n(n = 10, wt = num_flights)
  count(dest) %>%

# ordenar crescente
named_dests %>%
  arrange(num_flights)

# ordenar decrescente
named_dests %>%
  arrange(desc(num_flights))

# exemplo de salva arquivo csv
write.csv(fruit_counted, "fruit_counted.csv", row.names = FALSE)
