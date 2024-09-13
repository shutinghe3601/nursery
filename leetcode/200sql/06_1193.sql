-- 1193. Monthly Transactions I

-- each month, country, n_transcations, total_amount, n_approved, total_approved

-- use date_format to extract year_month from a date


select date_format(trans_date, '%Y-%m') as month, country, count(distinct id) as trans_count, 
sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from Transactions
group by date_format(trans_date, '%Y-%m'), country