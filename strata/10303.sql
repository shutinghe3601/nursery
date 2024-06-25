-- Top Percentile Fraud
-- Google, Netflix

-- top 5% percentile, use percentil_cont(percentile) within group(order by col) over(partition by)

with temp1 as 
(select state, percentile_cont(0.05) within group(order by fraud_score DESC) as percentile
from fraud_score
group by state)


select policy_num, f.state, claim_cost, f.fraud_score
from fraud_score f
left join temp1 t on f.state = t.state
where f.fraud_score >= t.percentile 


-- Other solution use ntile(100) over(partition by state order by fraud_score desc)
-- this function divide the data into 100 equal parts(tiles)
-- this is better because it will provide a fixed number (5) which can be used for where directly
select policy_num, state, claim_cost, fraud_score
from
(select *, ntile(100) over(partition by state order by fraud_score desc) as percentile
from fraud_score ) src
where percentile <= 5 -- top 5 are percentile below 5


-- # py
-- # use Series.rank to return percentile value, then filter value above 0.95
fraud_score['tile'] = fraud_score.groupby('state')['fraud_score'].rank(pct=True, ascending=True)
fraud_score[fraud_score['tile']> 0.95].drop(columns = 'tile')