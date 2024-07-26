-- Year Over Year Churn
-- ID 10017

-- comparing number of driver's churn between years
-- consider the left-year as the churn year

with t1 as
(select extract(year from end_date) as yr_churn, count(end_date) as num_churn
from lyft_drivers
where end_date is not null
group by extract(year from end_date))

select t1.yr_churn, t1.num_churn, COALESCE(t2.num_churn, 0), -- note that case when need to compare all values from here
case when t1.num_churn > COALESCE(t2.num_churn, 0)  then 'increase' else (
	case when t1.num_churn = COALESCE(t2.num_churn, 0)  then 'no change' else 'decrease' end
) end
from t1
left join t1 as t2 on t1.yr_churn = t2.yr_churn + 1
order by t1.yr_churn



-- try a more elegant coding

select extract(year from end_date) as yr_churn, count(end_date) as n_churns, 
	coalesce(lag(count(end_date), 1) over(order by extract(year from end_date) ASC), 0) as pre_churns,
	case when count(end_date) > coalesce(lag(count(end_date), 1) over(order by extract(year from end_date) ASC),0)  then 'increase' else (
		case when count(end_date) = coalesce(lag(count(end_date), 1) over(order by extract(year from end_date) ASC),0)  then 'no change' else 'decrease' end
	) end
from lyft_drivers
where end_date is not null
group by extract(year from end_date)