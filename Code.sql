Create database music_store_data_analysis;
use music_store_data_analysis;
# First i will import all the csv files one by one through the File inport Wizard 
show tables;
#all the tables are imported succesfully 
#Lets solve the questions one by one 
# Q.1 Who is the seniour most employee based on jobtitle?
select * from employee
order by levels desc
limit 1;
# Answer - Andrew Adams 
# Q.2 Which countries have the most Invoices? 
select count(*) as c, billing_country
from invoice 
group by billing_country
order by c desc;
# Hence usa has the most Invoices
# Q.3 What are top 3 values of total invoice? 
select total from invoice 
order by total desc
limit 3;
# Hence top three values are 23.7 , 19.8 & 19.8 
# Q.4 Which city has the best customers? We would like to throw a promotional Music Festival in the 
-- city we made the most money. Write a query that returns one city that has the highest sum of 
-- invoice totals. Return both the city name & sum of all invoice totals
select sum(total) as invoice_total, billing_city
from invoice
group by billing_city 
order by invoice_total desc;
-- Hence Prague is the best city with best customer
# Q.5 Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the 
-- most money 
select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer 
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id, customer.first_name, customer.last_name
order by total desc
limit 1;
-- Hence Franti Wichter is the best customer
-- 
--
# All the Set 1 Questions are solved!!
--
--
# Q.1 Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A
SELECT DISTINCT email, first_name, last_name
FROM `customer`
JOIN `invoice` ON `customer`.`customer_id` = `invoice`.`customer_id`
JOIN `invoice_line` ON `invoice`.`invoice_id` = `invoice_line`.`invoice_id`
WHERE `track_id` IN (
  SELECT `track_id` FROM `track`
  JOIN `genre` ON `track`.`genre_id` = `genre`.`genre_id`
  WHERE `genre`.`name` LIKE 'Rock'
)
ORDER BY `email`
LIMIT 0, 1000;
# Q.2 Let's invite the artists who have written the most rock music in our dataset. Write a 
-- query that returns the Artist name and total track count of the top 10 rock bands 
SELECT a.name AS artist_name, COUNT(t.track_id) AS total_track_count
FROM artist a
JOIN album al ON a.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY a.name
ORDER BY total_track_count DESC
LIMIT 10;
-- Here are the top 10 artist name & track count 
# Q.3 Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first 
select name, milliseconds
from track
where milliseconds > (
	select avg (milliseconds) as avg_track_length
    from track)
order by milliseconds desc;
-- Thanks for checking out my SQL Project 
-- Contact me anshulp544@gmail.com 