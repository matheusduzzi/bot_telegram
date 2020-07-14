---
title: "Bot da bolsa"
author: "Matheus Duzzi Ribeiro"
---

```{r}
usethis::edit_r_environ()
```

```{r}
library(telegram)
library(BatchGetSymbols)
library(lubridate)
library(forecast)

bot <- TGBot$new(token = bot_token('bot_name'))

bot$getMe()
```

```{r}
msgs <- bot$getUpdates()

msgs$message$chat$id[1]
```

```{r}
bot$set_default_chat_id('chat_id')
```

```{r}
# um dia tem 86400 segundos

acompanhar_acao <- function(frequencia = 86400) {
    while(TRUE) {
      
    ####### AMBEV  
      
    inicio <- "2018-01-01" 
    final <- Sys.Date()
    bench.ticker <- "^BVSP"
    saida <- BatchGetSymbols(tickers = "ABEV3.SA", first.date = inicio, last.date = final, 
                         bench.ticker = bench.ticker)
    saida <- as.data.frame(saida$df.tickers)

    row.names(saida) <- saida$ref.date
    m <- saida %>% select(-ref.date,-price.adjusted,-volume,-ticker,-ret.adjusted.prices,-ret.closing.prices)
    colnames(m) <- c("Open","High","Low","Close")
    
    dados_ts <- ts(na.exclude(m$Close),start= decimal_date(as.Date("2010-01-01")))
    modelo1 = nnetar(dados_ts)
    forc1 = forecast(modelo1,h=5)
    aux <- data.frame(forc1)
    
    
    bot$sendMessage('A previsão da cotação de ABEV3 para amanhã é: ')
    bot$sendMessage(format(round(aux[[1]], 2), nsmall = 2))
    
    ####### PETROBRÁS

    saida <- BatchGetSymbols(tickers = "PETR4.SA", first.date = inicio, last.date = final, 
                         bench.ticker = bench.ticker)
    saida <- as.data.frame(saida$df.tickers)

    row.names(saida) <- saida$ref.date
    m <- saida %>% select(-ref.date,-price.adjusted,-volume,-ticker,-ret.adjusted.prices,-ret.closing.prices)
    colnames(m) <- c("Open","High","Low","Close")
    
    dados_ts <- ts(na.exclude(m$Close),start= decimal_date(as.Date("2010-01-01")))
    modelo1 = nnetar(dados_ts)
    forc1 = forecast(modelo1,h=5)
    aux <- data.frame(forc1)
    
    bot$sendMessage('A previsão da cotação da PETR4 para amanhã é: ')
    bot$sendMessage(format(round(aux[[1]], 2), nsmall = 2))
    
    ############ AZUL
    
    saida <- BatchGetSymbols(tickers = "AZUL4.SA", first.date = inicio, last.date = final, 
                         bench.ticker = bench.ticker)
    saida <- as.data.frame(saida$df.tickers)

    row.names(saida) <- saida$ref.date
    m <- saida %>% select(-ref.date,-price.adjusted,-volume,-ticker,-ret.adjusted.prices,-ret.closing.prices)
    colnames(m) <- c("Open","High","Low","Close")
    
    dados_ts <- ts(na.exclude(m$Close),start= decimal_date(as.Date("2010-01-01")))
    modelo1 = nnetar(dados_ts)
    forc1 = forecast(modelo1,h=5)
    aux <- data.frame(forc1)
    
    bot$sendMessage('A previsão da cotação da AZUL4 para amanhã é: ')
    bot$sendMessage(format(round(aux[[1]], 2), nsmall = 2))
    
    ############ VVAR3
    
    saida <- BatchGetSymbols(tickers = "VVAR3.SA", first.date = inicio, last.date = final, 
                         bench.ticker = bench.ticker)
    saida <- as.data.frame(saida$df.tickers)

    row.names(saida) <- saida$ref.date
    m <- saida %>% select(-ref.date,-price.adjusted,-volume,-ticker,-ret.adjusted.prices,-ret.closing.prices)
    colnames(m) <- c("Open","High","Low","Close")
    
    dados_ts <- ts(na.exclude(m$Close),start= decimal_date(as.Date("2010-01-01")))
    modelo1 = nnetar(dados_ts)
    forc1 = forecast(modelo1,h=5)
    aux <- data.frame(forc1)
    
    bot$sendMessage('A previsão da cotação da VVAR3 para amanhã é: ')
    bot$sendMessage(format(round(aux[[1]], 2), nsmall = 2))
    
    Sys.sleep(frequencia)
  }
}
```

```{r}
Sys.sleep(15)
acompanhar_acao()
```

