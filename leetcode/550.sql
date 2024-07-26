-- 550. Game Play Analysis IV

-- fraction of playeer of second login, .2f
-- num_players, at least 2 consecutive days/ total_players

-- use lead to get value from following row
-- datediff(endday, startday)

select round(sum(case when date_diff <= 1 then 1 else 0 end)/count(*), 2) as fraction
from 
(select player_id, event_date, 
lead(event_date, 1) over(partition by player_id order by event_date asc) as second_log,
datediff(lead(event_date, 1) over(partition by player_id order by event_date asc), event_date) as date_diff
from Activity
) date_diff
where (player_id, event_date) in
(select player_id, min(event_date)
from Activity
group by player_id)


-- use target second_log to filter value, then use this value/original count(distinct players)
-- use cast to determine decimal
-- use date_add to find target second_log
select cast(count(*)/(select count(distinct player_id) from activity) as decimal(10,2)) as fraction
from activity
where (player_id , date_add(event_date, interval -1 day)) in 
(select player_id, min(event_date)
from activity
group by player_id)



 