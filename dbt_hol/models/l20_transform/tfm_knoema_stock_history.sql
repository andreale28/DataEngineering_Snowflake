WITH cst AS
(
SELECT company_ticker, company_name, stock_exchange_name, indicator_name, Date, Value, data_source_name
  FROM {{ref('base_knoema_stock_history')}} src
 WHERE indicator_name IN ('Close', 'Open','High','Low', 'Volume', 'Change %')
)
SELECT *
  FROM cst
  PIVOT(SUM(Value) for indicator_name IN ('Close', 'Open','High','Low', 'Volume', 'Change %'))
  AS p(company_ticker, company_name, stock_exchange_name, date, data_source_name, close ,open ,high,low,volume,change)