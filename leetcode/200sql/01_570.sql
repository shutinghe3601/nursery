-- 570. Managers with at Least 5 Direct Reports

select name
from Employee
where id in 
(select managerId --, count(managerId) as num_reports
from Employee
group by managerId
having count(managerId) > 4
)