-- Growth of Airbnb
-- ID 9637

-- num_hosts_rate: (num_this_year - num_prev)/num_prev * 100
-- year, num_this_year, num_prev, round(rate)
-- order by year asc

select *, round((num_year - num_prev)/cast(num_prev as float) * 100) # need to convert denomintor to float to get float answer 
from
(select extract(year from host_since) as year,
count(distinct id) as num_year,
lag(count(distinct id), 1) over(order by extract(year from host_since) asc) as num_prev
from airbnb_search_details
group by extract(year from host_since))src
order by year