-- 10313.Naive Forecasting
-- Uber

-- sum 'distance to travel' and 'monetary cost', group by month, compute the avg
-- extarct value from previous month 
-- compute RMSE (sqrt(mean(square(actual - forecast)))), .2f

select round(cast(sqrt(avg(power(actual - forecast,2))) as numeric), 2) as RMSE
from (
	select to_char(request_date, 'YYYY-MM') as year_month, 
	sum(distance_to_travel)/sum(monetary_cost) as actual, 
	coalesce(lag(sum(distance_to_travel)/sum(monetary_cost)) over (order by to_char(request_date, 'YYYY-MM')),0) as forecast
	from uber_request_logs
	group by to_char(request_date, 'YYYY-MM')
) as src
where forecast != 0

-- square(value) use power(value, idx)
-- if round() doesn't work, try to cast it to numeric
-- lag() over(order by .. ) returns the value from last row 


-- # py

-- use .shift(n) to extract value from previous n row
import pandas as pd
import datetime as dt
import numpy as np

df = uber_request_logs.copy()

df['request_date'] = pd.to_datetime(df['request_date'])
df['year_month'] = df['request_date'].dt.strftime('%Y-%m')
df = df.groupby('year_month').agg('sum')
df['actual'] = df['distance_to_travel']/df['monetary_cost']
df['forecast'] = df['actual'].shift(1)
df['r'] = (df['actual'] - df['forecast']) ** 2
df['rm' ] = df['r'].mean()
df['rmse'] = round(np.sqrt(df['rm']).values[0], 2)

