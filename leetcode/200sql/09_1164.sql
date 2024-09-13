-- 1164. Product Price at a Given Date


-- find all products on 2019-08-16, if no new_price, return 10

-- return price of <= 2019-08-16 but max(date)

-- change_date equal or before 2019-08-16

select p1.product_id, coalesce(p2.new_price, 10) price
from (select distinct product_id from products) p1
left join
(select product_id, new_price
from products
where (product_id, change_date) in
(select product_id, max(change_date)
from products
where change_date <= '2019-08-16'
group by product_id)) p2 on p1.product_id = p2.product_id