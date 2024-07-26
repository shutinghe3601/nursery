-- Best Selling Item
-- ID 10172

with t1 as 
(
	select description, extract(month from invoicedate) as month, sum(quantity * unitprice) as sales 
	from online_retail
	group by description, extract(month from invoicedate)
)


select t1.* 
from t1 
left join
(
	select month, max(sales) as max_sales
	from t1
	group by month
) t2 
on t1.month = t2.month
where t1.sales = t2.max_sales
order by t1.month