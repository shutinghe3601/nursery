-- 10314.Revenue Over Time
-- Amazon

-- 3 month rolling avg of total revenue
-- no negative purchases
-- output year-month and 3 month rolling avg
-- first two rolls shouldn't be 3 month rolling

-- sql
select year_month, 
	avg(amount_month) over(
		order by year_month
		rows between 2 preceding and current row
) rolling_average -- computing rolling avg
from (
	select to_char(created_at,'YYYY-MM') as year_month, sum(purchase_amt) as amount_month
	from amazon_purchases
	where purchase_amt >= 0
	group by to_char(created_at,'YYYY-MM')
) as src


-- #### py

import pandas as pd
import datetime as dt
df = amazon_purchases[amazon_purchases['purchase_amt'] > 0]
df['created_at'] = pd.to_datetime(df['created_at'])

df['year_mon'] = df['created_at'].dt.strftime('%Y-%m')
df = df.groupby('year_mon').agg({'purchase_amt':'sum'}).reset_index()

-- # compute rolling average by col.rolling func
df['rolling_avg'] = df['purchase_amt'].rolling(window = 3, min_periods = 1).mean()
df.drop(columns = 'purchase_amt')


