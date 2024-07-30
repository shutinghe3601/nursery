-- Worst Businesses
-- ID 9739

-- worst business(most violations)/year
-- year, business name, number of violations

select year, business_name, n_vio
from
(
	select extract(year from inspection_date) as year,
	business_name, count(distinct violation_id) as n_vio,
	rank() over (partition by extract(year from inspection_date) order by count(distinct violation_id) desc) as r
	from sf_restaurant_health_violations
	group by extract(year from inspection_date), business_name
) src
where r = 1
order by year