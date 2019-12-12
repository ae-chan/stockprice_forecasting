# Stock Price Forecasting
Using Prophet by Facebook to forecast stock prices fed by the Yahoo Finance API

## Getting started (settings.env)
Provide input for "symbol" (string representing ticker symbol); "start_date" and "end_date" (string formatted as YYYY-MM-DD representing timespan of data to pull from Yahoo Finance API); "pred_length" (integer representing span of forecast in days); and "seasonality" (boolean representing whether or not to generate a seasonality components graph).

## Executing the script (stockprice_prophet.R)
Code may be executed directly without user changes to the code. Changes may be made to cross-validation procedure.

## Output ("/figures" folder)
Stores all outputs. Title is formatted as "symbol@[average mean absolute percentage error].html" for quick screening of predictive accuracy on each stock.

## Functionalities to be added:
1. readme.md screenshots
2. Multi-stock forecasting (simultaneously)
3. First derivative forecasting
