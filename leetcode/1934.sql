-- 1934. Confirmation Rate

-- comfirmation rate = number of confirmed / total messages (.2f)
-- each user 

-- return all user_id from Signups, compute confirmation rate for each user

select s.user_id, coalesce(round(cast(t1.n_confir/t1.total as float), 2), 0) as confirmation_rate
from
(
select user_id, 
count(case when action = 'confirmed' then action else null end) as n_confir,
count(time_stamp) as total
from Confirmations
group by user_id
) t1
right join Signups s on s.user_id = t1.user_id


-- using avg
-- And you can group by when using join

select s.user_id, 
coalesce(round(avg(case when action = 'confirmed' then action else 0 end), 2),0) as confirmation_rate
from Confirmations
right join Signups s using (user_id)
group by s.user_id -- this should be the merged key