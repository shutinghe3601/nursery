--  1045.Customers Who Bought All Products

-- customer_id that brought all products in product table

select customer_id 
(select distinct *
from customer
) no_duplicate
group by customer_id
having count(product_key) = 
(
	select count(*)
	from product
)


-- way that reduce one subquery
select customer_id
from customer 
group by customer_id
having count(distinct product_key) = (select count(*) from product)
