--OPEN-ENDED QUESTIONS
--Which is the leading brand in the Dips & Salsa category?
--Assumptions: I am basing this on how often these brands show up on receipts.
--Answer: The leading brand in the dips & salsa category is Tostitos.

select p.brand, count(distinct receipt_id) as count_receipt_id
from transactions as t
left join products as p on p.barcode = t.barcode
where lower(p.category_2) like '%dip%'
group by 1
having brand is not null
order by count_receipt_id desc
limit 5
