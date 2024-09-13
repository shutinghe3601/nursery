-- 1070. Product Sales Analysis III

-- product id, year, quantity, price for the first yeat of *every product* sold (which stored in table product)

select p.product_id, coalesce(s.year, 0) as first_year,
coalesce(s.quantity, 0) as quantity,
coalesce(s.price, 0) as price 
from sales s
right join product p on p.product_id = s.product_id
where (p.product_id, s.year) in
(select product_id, min(year)
from sales
group by product_id)