-- Sales Percentage Week's Beginning and End
-- ID 2165

with t0 as 
(select date, extract(week from date) as week_num, extract(dow from date) as week_day,
sum(sales) as daily_sales
from 
(select quantity*unitprice as sales, to_date(invoicedate, 'DD/MM/YYYY') as date
from early_sales) bse
group by date)

-- three tables
select t3.week_num, round(coalesce(t1.daily_sales,0)/t3.weekly_sales * 100) as frist_day,
round(coalesce(t2.daily_sales,0)/t3.weekly_sales * 100) as last_day
from 
(
	select week_num, week_day, daily_sales
	from t0
	where week_day = 1
) t1

full join 
(
	select week_num, week_day, daily_sales
	from t0
	where week_day = 0
)
 as t2 on t1.week_num = t2.week_num 
join 
(
	select week_num, sum(daily_sales) weekly_sales
	from t0
	group by week_num
) t3 on t3.week_num = t1.week_num or t3.week_num = t2.week_num

