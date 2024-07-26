-- 1174. Immediate Food Delivery II

-- same day as order day: immediate, else scheduled
-- immediate rate of first order of all customer
-- n_imme/total_first_order 


--note: cannot use following sql, because pref return unaligned value
--select customer_id, min(order_date) as first_order, customer_pref_delivery_date as pref

select round(cast(
	sum(
		case when first_order = pref then 1 else 0 end
	)/count(first_order) * 100 as float),2) as immediate_percentage 
from 
(-- first order
select t1.customer_id, t1.first_order, d.customer_pref_delivery_date as pref 
from Delivery d
right join
(select customer_id, min(order_date) as first_order
from Delivery
group by customer_id 
) t1
on d.customer_id = t1.customer_id and d.order_date = t1.first_order
) src



-- you can assign two conditions like this in where clause
select 
	round(avg(order_date = customer_pref_delivery_date) * 100, 2) as immediate_percentage
from Delivery
where (customer_id, order_date) in 
(select customer_id, min(order_date)
from Delivery
group by customer_id)


