# Stock Price Forecasting
Using Prophet by Facebook to forecast stock prices fed by the Yahoo Finance API

## Getting started
In "settings.env":
Provide input for "symbol" (string representing ticker symbol); "start_date" and "end_date" (string formatted as YYYY-MM-DD representing timespan of data to pull from Yahoo Finance API); "pred_length" (integer representing span of forecast in days); and "seasonality" (boolean representing whether or not to generate a seasonality components graph).

## Execute "stockprice_prophet.R"

## In "/figures" folder
Refer to this folder for forecast output. Title is formatted as "symbol@[average mean absolute percentage error].html"
