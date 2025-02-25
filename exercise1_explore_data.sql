--EXPLORE THE DATA
----USERS TABLE
select *
from users
limit 100

--Number of rows in table = 100,000
select count(*)
from users

--Checking id is not listed more than once
--Findings: There are no rows with duplicate ids or null
--Assume: id is the primary key
select id, count(id) as id_count
from users
group by id
order by id_count 
limit 100

--Checking columns for null values
--Null values: birth_date (3675), state (4812), language (30508), gender (5892)
select count(*)
from users
where gender is null

--Checking for outliers - birth_date
--Findings: 62 users are over 100 years old, 14 users below 5 years old
select extract(year from birth_date) as birth_year, count(id) as id_count
from users
group by birth_year
--having extract(year from birth_date) <= 1925
order by birth_year desc

--Checking for outliers - state
--Findings: All 50 states listed including D.C., Puerto Rico, null
select distinct state
from users
order by state

--Checking distinct values - language
--Findings: null, en (assuming this is English), es-419 (assuming this is Spanish)
select distinct language
from users

--Checking distinct values - gender
--Findings: There are the same options written in different ways (e.g. Non-Binary/non_binary, Prefer not to say/prefer_not_to_say)
select distinct gender
from users
order by gender



----PRODUCTS TABLE
select *
from products
limit 100

--Number of rows in table = 845,552
select count(*)
from products

--Checking barcode is not listed more than once
--Findings: barcode is not unique, 185 rows with duplicate barcodes
--Question: Why do some products have the same barcode?
select barcode, count(barcode) as barcode_count
from products
group by barcode
order by barcode_count
limit 200

--Checking columns for null values
--Null values: category_1 (111), category_2 (1424), category_3 (60566), category_4 (778093), manufacturer (226474), brand (226472), barcode (4025)
select count(*)
from products
where barcode is null

--Checking distinct values
--Findings: Category1 seems the most broad, category4 is the most specific
select distinct category_4
from products
order by category_4



----TRANSACTIONS TABLE
select *
from transactions
limit 100

--Number of rows in table = 50,000
select count(*)
from transactions

--Checking receipt_id is not listed more than once
--Findings: receipt_id is not unique
select receipt_id, count(receipt_id) as receipt_id_count
from transactions
group by receipt_id
order by receipt_id_count desc
limit 100

--Checking columns for null values
--Null values: barcode (5762)
--Question: Are these products new products? Why isn't there any data about these products?
select count(*)
from transactions
where barcode is null

--Checking for outliers - purchase_date
--Findings: All purchases were completed in 2024
select extract(year from purchase_date) as purchase_date_year, count(receipt_id) as receipt_id_count
from transactions
group by purchase_date_year
order by purchase_date_year desc

--Checking distinct values - quantity
--Findings: Data types in quantity column are inconsistent (e.g.‘zero’ and ‘1’) so I updated 'zero' to show a number, 0.00 quantity to 276.00 quantity
--Question: Why is quantity a decimal?
select distinct quantity
from transactions
order by quantity

update transactions
set quantity = 0.00
where quantity = 'zero'

alter table transactions
alter column quantity
type numeric
using quantity::numeric

--Checking distinct values - sale
--Assume: This is the price of the transaction. 
--Question: What do the transactions with sale = 0.00 represent? Are these returns?
select distinct sale
from transactions
order by sale 
limit 100

--Checking relationship between quantity and sale
--Question: What is the relationship between transaction & sale?
select distinct quantity, sale
from transactions
limit 100