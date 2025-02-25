--OPEN-ENDED QUESTION
--At what percent has Fetch grown year over year?
--Assumptions: I am basing this off of the year over year growth of users joining Fetch.
--Answer: Fetch user count has had positive growth up until 2023 where a negative rate has started and continued into 2024. It had reached its peak in 2017 where the user growth rate hit 821%. 

select 
	created_year, 
	user_id_count,
	round(((((user_id_count - user_count_previous_year)::decimal)/user_count_previous_year) * 100),1) as yoy_user_growth_percentage
from
(select
	extract(year from created_date) as created_year, 
	count(distinct id) as user_id_count,
	lag(count(distinct id)) over (order by extract(year from created_date)) as user_count_previous_year
from users
group by 1)
