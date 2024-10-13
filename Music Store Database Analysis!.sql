Questions SET 1:

1) Who is the senior most employeee based on the job title?

Select * from employee
Order By levels desc
limit 

2) Which countries have the most invoices?

Select COUNT (*) as c, billing_country
from invoice
group by billing_country
order by c desc
limit 5

3) What are top 3 values of total invoice?

select total from invoice
order by total desc 
limit 3

4) Which city has the best customers? We would like to throw a promotional 
Music Festival in the city we made the most money. Write a query that returns 
one city that has the highest sum of invoice totals. Return both the 
city name & sum of all invoice totals

select SUM(total) as invoice_total, billing_city
from invoice
group by billing_city
Order by invoice_total desc

5) Who is the best customer? The customer who has spent the most money will 
be declared the best customer. Write a query that returns the person who has 
spent the most money

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM (invoice.total) as total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
limit 1

-------------------------------------------------------------------------------------------------------------------------------------------

Questions SET 2:

1) Write query to return the email, first name, last name, & Genre of all
Rock Music listeners. Return your list ordered alphabetically by email starting with A

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id from track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;


2) Let's invite the artists who have written the most rock music in our dataset. 
Write a query that return's the Artist name and total track count of the top 10 rock bands

SELECT artist.artist_id, artist.name, COUNT (artist.artist_id) AS number_of_songs 
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10

3) Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

SELECT name, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG (milliseconds) AS avg_track_length
	FROM track
)
ORDER BY milliseconds DESC;
