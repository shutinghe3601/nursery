-- 10358.Friday Purchases 


-- sql

-- Solution:
-- create a avg_friday_purchase table and generate a week_number_series table
-- merge them based on week_number, which extaracted by extract(week from date)
-- finally use coalesce(col, 0) makes all null returns to 0

-- Key learning: 
-- 1. extract(unit from date_col) returns extract unite number from that date
-- 1.5 using extract(week from date_col) returns week_number of that date. PostgreSQL recognize the week with first Thursday as the first week of the year, while mySQL offers two options
-- 2. generate_series(start, end, interval) returns series from start to end with determined interval. start/end can be number, date...
-- 3. coalesce(col, number) return non-null values and all null values are replaced by number

with friday_purchase AS
(select extract(week from date) as week_number, avg(amount_spent) as avg_amount
from user_purchases
where extract(month from date) <= 3 and day_name = 'Friday'
group by date),
week_series As
(select extract(week from date_series) as week_number
from generate_series('2023-01-01'::date, '2023-03-31'::date, '1 day'::interval) as date_series
where extract(week from date_series) < 20
group by extract(week from date_series)
order by extract(week from date_series))

select ws.week_number, coalesce(fp.avg_amount , 0) as avg_amount
from week_series as ws
left join friday_purchase as fp 
    on ws.week_number = fp.week_number

	
-- an elegant solution:
-- filter quater that's not 1, and year that's not 2023 (extarct(isoyear from date_col))
-- note, it has to be isoyear to return the ISO standard year (aligned with week number)
-- Strength: no need to build two temp table

select extract(week from date) as week_num, 
	coalesce(avg(case when day_name = 'Friday' then amount_spent else end), 0) as avg_amount
from user_purchases
where extract(quarter from date) =1 and extract(isoyear from date) = 2023
group by extract(week from date)


-- #### py

import pandas as pd

-- # Get ISO week number
-- # iso_week_numbers = dates.dt.isocalendar().week
-- # NOTE: don't group by a date columns, because it can be very granular, group by a specific date part, like year, month, or day

date = pd.Series(pd.date_range(start = '2023-01-01', end='2023-03-31', freq = 'W-FRI'))
week_num = date.dt.isocalendar().week
week_df = pd.DataFrame(data = {'week_num': week_num.unique()})

user_purchases['date'] = pd.to_datetime(user_purchases['date'])
user_friday = user_purchases[user_purchases['day_name'] == 'Friday']
user_friday['week_num'] = user_friday.date.dt.isocalendar().week
avg_amount = user_friday.groupby(by = 'week_num').mean().reset_index()[['week_num','amount_spent']]

-- # merge
week_df.merge(avg_amount, how = 'left', on = 'week_num').fillna(0)

-- ## elegant way by using assign
-- ### The assign method allows you to create new columns or overwrite existing ones by specifying keyword arguments
-- ### query is an easy way to filter value by inputing strings
date = pd.Series(pd.date_range(start = '2023-01-01', end='2023-03-31', freq = 'W-FRI'))
week_num = date.dt.isocalendar().week

user_purchases.assign(week_num = pd.to_datetime(user_purchases['date']).dt.isocalendar().week
).query('day_name == "Friday"'
).groupby('week_num').mean().reset_index(
).merge(pd.DataFrame(data = {'week_num': week_num.unique()}), how = 'right', on = 'week_num'
).fillna(0
)[['week_num','amount_spent']]