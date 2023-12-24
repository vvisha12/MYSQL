use music_store;
select * from music_store.album;
select * from music_store.artist;
select * from music_store.customer;
select * from music_store.genre;
select * from music_store.invoice;
select * from music_store.invoice_line;
select * from music_store.media_type;
select * from music_store.playlist;
select * from music_store.playlist_track;
select * from music_store.track;
select * from employee;
select * from employee order by levels desc limit 1;
select concat(first_name," ",last_name),title,levels from employee order by levels limit 1;
-- Project Starts--
-- Set A--
select * from employee;
-- Q.1) Who is the senior most employee based on the job title?--
 select concat(first_name," ",Last_name),title,levels from employee order by levels desc  limit 1;
 -- Q.2) Which country have the most invoice?--
 select * from invoice;
 select count(*) as total,billing_country from invoice group by billing_country order by total desc;
 select * from invoice;
 select * from invoice_line;
 select count(*) as Total ,billing_country from invoice group by billing_country order by Total desc limit 5;
 select count(*) as total,billing_country from invoice group by billing_country order by total desc;
 -- Q.3) What are top 3 values of total invoice --
 select * from invoice;
 select * from invoice order by total desc limit 3;
 /* Q.4) Which city has the best customers? We would like to through a promotional music festival in the city 
 we made the most money Write a query that returns one city that has the highest  sum of invoice totals. Return both the city name & sum of all invoice totals */
select * from customer;
select * from invoice;
select c.city,round(sum(i.total),2) as total from customer as c join invoice as i on i.customer_id=c.customer_id
group by c.city order by total desc limit 10 ;
 -- Q.5) WHo is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person whic has spent the most money. --
 select * from customer;
 select * from invoice;
 select concat(first_name,' ',last_name) as emp_name,round(sum(total)) as Spent_money from customer join invoice on
 invoice.customer_id=customer.customer_id group by emp_name order by Spent_money desc limit 1;
 select * from customer;
 select * from invoice;
 select customer.customer_id,customer.first_name,customer.last_name,sum(invoice.total) as total from customer join invoice on invoice.customer_id=customer.customer_id 
 group by customer_id order by total desc limit 1;
 -- Question set 2 Moderate--
 /* Q.1) Write query to return the email ,first name, last name &  your list ordered genre of all rock music listeners. 
 Rerurn alphabetically by email starting with A */
select * from customer;
select * from genre;
select * from track;
select * from invoice_line;
select * from invoice;
select * from customer;

select customer.email as email,customer.first_name,customer.last_name,genre.genre_id,genre.name from customer join
invoice on invoice.customer_id=customer.customer_id 
join invoice_line on invoice_line.invoice_id=invoice.invoice_id
join track on track.track_id=invoice_line.track_id
join genre on genre.genre_id=track.genre_id where genre.name= 'Rock' and email like 'a%' order by customer.email;

select * from customer;
select * from genre;
select * from track;
select * from invoice_line;
select * from invoice;
select * from customer;
select track_id from track join genre on track.genre_id=genre.genre_id where genre.name like 'rock';

select distinct email as email,first_name,last_name from customer 
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice_line.invoice_id=invoice.invoice_id
 where track_id in(
 select track_id from track join genre on track.genre_id=genre.genre_id where genre.name like 'rock'
 )
 order by email;
 
 select * from customer;
 select * from invoice;
 select * from invoice_line;
 select * from genre;
 select * from track;
 
 select distinct email, first_name,last_name from customer join invoice on customer.customer_id = invoice.customer_id
 join invoice_line on invoice.invoice_id=invoice_line.invoice_id where track_id in ( select track_id from  track join genre on
 track.genre_id=genre.genre_id where genre.name like 'Rock') order  by email;
  /*Q.2) Invite the artists who have written the most rock music in our dataset. 
  Write a query that returns the artist name and total track count of the top 10 rock bands.*/
 select * from artist;
 select * from track;
 select * from album;
 select * from genre;
select ar.name as artist_name,count(al.title) as total,ge.name as genre_type from track as tr join 
album as al on tr.album_id=al.album_id join genre as ge on ge.genre_id=tr.genre_id join artist as ar on
ar.artist_id=al.artist_id where ge.name like "Rock" group by artist_name,genre_type order by total desc;
select * from genre;
select * from track;
select * from album; 
 select * from artist;
  -- Q.2) Invite the artists who have written the most rock music in our dataset. Write a query that returns the artist name and total track count of the top 10 rock bands.--
 select artist.id,artist.name,count(artist.artist_id) as Number_Of_Songs from artist join album on artist.artist_id=album.artist_id
 join track on album.album_id=track.album_id join genre on track.genre_id=genre.genre_id;
 
 
 
 select * from genre;
select * from track;
select * from album; 
 select * from artist;
 
 /* Q.3) Return all the track names that have a song length longer than the average song legnth. 
 Return the name and milliseconds for each track.
 Order by the song lenghth with the longest songs listed first. */
 select * from track;
 
 select name ,milliseconds from track where milliseconds>(select avg(milliseconds) as avg_track_lenghth from track)  order by milliseconds desc;
 
 select * from track;
 select name,milliseconds from track where milliseconds>(select avg(milliseconds) from track) order by milliseconds desc limit 5;
 
select name,milliseconds from track where milliseconds > (select avg(milliseconds) as avg_length_track from track) order by milliseconds desc;

-- Question set 3 --
-- Q.1) Find how much amont spent by each customer on artists? Write a query to return customer name, artist name and total spent.alter
select * from invoice;
select * from customer;
select * from artist;
select * from invoice_line;
select * from album;

use music_store;



select * from invoice_line;
use music_store;
select * from invoice;
With best_selling_artist as (select artist.artist_id as artist_id,artist.name as artist_name,sum(invoice_line.unit_price*invoice_line.quantity)
as total_sales from invoice_line
join track on track.track_id = invoice_line.track_id
join album on album.album_id=track.album_id
join artist on artist.artist_id = album.artist_id
group by 1
order by 3 desc 
limit 1)
 select c.customer_id,c.first_name,c.last_name,bsa.artist_name,sum(il.unit_price*il.quantity) as amount_spent from invoice i join customer c ON c.customer_id=i.customer_id
 join invoice_line as il on il.invoice_id = i.invoice_id join track as t ON t.track_id=il.track_id join album alb on alb.album_id=t.album.id
 join best_selling_artist bsa on bsa.artist_id = alb.artist_id
 group by 1,2,3,4
 order by 5 desc;
 
 select * from invoice_line;
 select * from track;
 select * from artist;
select * from album; 






 -- Q.2) Find the most popular music genre for each country. We determine the most popular genre as the genre with the highest amount of purchases.Write a query that --
-- returns each country along with the tip genre. For countries where the maximum number of purchases is shared return all genres. -- 
 
 With popular_genre AS
 ( Select count(invoice_line.quantity) AS purchases, customer.country,genre.name,genre.genre_id,row_number () over (PARTITION BY customer.country order by count (invoice_line.quantity) DESC)
 as rowNo from invoice_line
 join invoice on invoice.invoice_id = invoice_line.invoice_id
 join customer on customer.customer_id = invoice.customer_id
 join track on track.track_id = invoice_line.track_id
 join genre on genre.genre_id = track.genre_id
 group by 2,3,4
 order by 2 asc,1 desc)
 select * from popular_genre where Rowno <= 1;
 mysql-V
 