--CLOSED-ENDED QUESTION	
--What are the top 5 brands by receipts scanned among users 21 and over?
--Answer: (Not including null brands) Dove, Nerds candy, Coco-cola, Great value, Meijer, Trident, Hershey's, Sour patch kids
--There are more than 5 brands listed. This is because many of the brands have the same receipt count value.

select brand, count(distinct receipt_id) as receipt_count
from
(	select t.receipt_id, p.brand, extract(year from age(current_date, u.birth_date)) as user_age
	from transactions as t
	left join products as p on t.barcode = p.barcode
	left join users as u on t.user_id = u.id
	where extract(year from age(current_date, u.birth_date)) >= 21
)
group by brand
order by 2 desc
limit 10