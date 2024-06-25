-- Title: Distance Per Dollar
-- Uber

-- diff between these two things:: distance_per_dollar/date and (groupby) avg_ distance_per_dollar/year_month
-- output yyyy_mm, .2f avg_diff, sort date 
-- Note lag return the actual value from previous rows but not the difference, however lag is not used here
-- cannot use round(col, num) directly, cast the col to numeric first

with temp1 as
(select to_char(request_date::date, 'YYYY-MM') as year_month,
avg(distance_to_travel/monetary_cost) avg_dist_dollar
from uber_request_logs
group by to_char(request_date::date, 'YYYY-MM'))

select t2.year_month, avg(round(cast(abs(t2.dist_dollar - t1.avg_dist_dollar)as numeric),2)) as avg_diff
from
(select to_char(request_date::date, 'YYYY-MM') as year_month, 
	distance_to_travel/monetary_cost dist_dollar
from uber_request_logs) t2
left join temp1 t1 on t1.year_month = t2.year_month
group by t2.year_month
order by t2.year_month


-- # py

import pandas as pd
import datetime as dt
uber_request_logs['year_month'] = uber_request_logs['request_date'].dt.to_period('M')
uber_request_logs['dist_dollar'] = uber_request_logs['distance_to_travel']/uber_request_logs['monetary_cost']
avg_df = uber_request_logs.groupby('year_month').agg({'dist_dollar':'mean'}).reset_index()[['year_month','dist_dollar']]
uber_request_logs = uber_request_logs.merge(avg_df, how = 'left', on ='year_month')
uber_request_logs['diff'] = abs(uber_request_logs['dist_dollar_x'] - uber_request_logs['dist_dollar_y'])
result = uber_request_logs.groupby('year_month').agg({'diff':'mean'})['diff'].apply(lambda x: round(abs(x),2)).reset_index()


