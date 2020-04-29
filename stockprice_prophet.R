#package loading
library(rtsdata)
library(ggplot2)
library(prophet)
library(htmlwidgets)

#pull .env variables
root <- "/Users/anthony_chan/Google Drive/Projects/Stockprice_Forecasting/"
figures <- "/Users/anthony_chan/Google Drive/Projects/Stockprice_Forecasting/figures"
setwd(root)
readRenviron("settings.env")
symbol <- Sys.getenv("symbol")
start_date <- Sys.getenv("start_date")
end_date <- eval(parse(text = Sys.getenv("end_date")))
pred_length <- as.numeric(Sys.getenv("pred_length"))
seasonality <- as.logical(eval(Sys.getenv("seasonality")))

#fetch function from yahoo
yahoo.fetch <- function(symbol, start_date, end_date) {
  df <- ds.getSymbol.yahoo(symbol, from = start_date, to = end_date)
  df <- fortify(df)
  df <- df[,c(1,7)]
  df[is.na(df)] <- 0
  names(df) <- c("ds", "y")
  return(df)
}

#cross-validate over every week for the past half year
cv <- function() {
  #df.cv <- cross_validation(model, initial = end_date - as.Date(start_date) - floor(365/2), period = 7, horizon = pred_length, units = 'days')
  df.cv <- cross_validation(model, initial = floor(365*(4/3)), period = pred_length, horizon = pred_length, units = 'days')
  df.p <- performance_metrics(df.cv)
  AMAPE <- mean(df.p$mape)
  return(round(AMAPE,3))
}

#data visualization output
output.graphs <- function(AMAPE) {
  setwd(figures)
  
  if (seasonality) {
    jpeg(paste(symbol, "-seasonality.jpg", sep = ""))
    prophet_plot_components(model, forecast)
    dev.off()
  }
  
  interactive_plot <- dyplot.prophet(model, forecast, uncertainty = TRUE)
  saveWidget(interactive_plot, paste(symbol, "@", Sys.Date(), " [", AMAPE, "].html", sep = ""),
             title = paste(symbol, " Forecasted to ", end_date + pred_length, sep = ""))
  
  setwd(root)
}

#core function calls for modelling and forecasting
df <- yahoo.fetch(symbol, start_date, end_date)
model <- prophet(df, daily.seasonality=TRUE)
future <- make_future_dataframe(model, periods = pred_length)
forecast <- predict(model, future)
output.graphs(cv())
