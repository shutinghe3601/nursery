-- Title: Employees with Same Birth Month
-- Block 

-- create a pivot table, extract month as col, profession as index, unique employee_id as value

select profession as department,
	-- count(distinct case when birth_month = 1 then employee_id else 0 end) as Month_1,*
	count(distinct case when birth_month = 1 then employee_id end) as month_1,
	count(distinct case when birth_month = 2 then employee_id end) as month_2,
	count(distinct case when birth_month = 3 then employee_id end) as month_3,
	count(distinct case when birth_month = 4 then employee_id end) as month_4,
	count(distinct case when birth_month = 5 then employee_id end) as month_5,
	count(distinct case when birth_month = 6 then employee_id end) as month_6,
	count(distinct case when birth_month = 7 then employee_id end) as month_7,
	count(distinct case when birth_month = 8 then employee_id end) as month_8,
	count(distinct case when birth_month = 9 then employee_id end) as month_9,
	count(distinct case when birth_month = 10 then employee_id end) as month_10,
	count(distinct case when birth_month = 11 then employee_id end) as month_11,
	count(distinct case when birth_month = 12 then employee_id end) as month_12
from employee_list
group by profession

* 
-- always put distinct at front
-- in count() if set up a else condition (such as else 0), it will count 0 as a number
-- so don't set else condition if you don't want an extra number

-- #### py 

import pandas as pd

-- # not a one_hot_encoder problem, but a pivot table one

pd.pivot_table(employee_list, 
    values = 'employee_id', 
    index = 'profession', 
    columns = 'birth_month', 
    aggfunc = pd.Series.nunique, 
    fill_value = 0
    ).reset_index()