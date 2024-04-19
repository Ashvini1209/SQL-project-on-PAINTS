-- use database 
use paints;
-- use painting;

-- show tables-

show tables;

select * from artist;

select * from museum;

select * from product_size;
select * from subject;
select * from work;

select * from canvas_size;
-- Joining Tables:

-- 1. Retrieve the full name of artists along with the names of the museums where their works are displayed.
select a.full_name as Artist_name,m.name as Museum_name,w.name as work
from artist as a
inner join work as w
on a.artist_id=w.artist_id
inner join museum as m
on w.museum_id=m.museum_id;
-- order by Artist_name,Museum_name,work;


-- 2. Group By and Count:
-- How many works does each artist have in the database? Display the artist's full name along with the count of their works, ordered by the count in descending order.
select count(style) as countwork 
from artist;

select a.full_name,count(w.name) as countwork
from artist as a
left join 
work as w
on
a.artist_id=w.artist_id
group by full_name
order by countwork desc;



-- 3. Order By and Limit:
-- List the top 5 museums with the highest number of works displayed in the database, along with their respective counts.
select m.name as museum_name,count(work_id) as work_count 
from museum as m
left join work as w 
on
m.museum_id=w.museum_id
group by museum_name
order by work_count desc
limit 5;



-- 4. Join, Order By, and Limit:
-- Display the names and styles of the works along with the corresponding museum names, ordered by the museum name in ascending order. Limit the results to 10.
select w.name,w.style,m.name
from work as w
inner join museum as m
on
w.museum_id=m.museum_id
order by m.name,w.name
limit 10;




-- 5.Join, Group By, and Sum:
-- Show the total sale price for each artist's works. Display the artist's full name along with the total sale price, ordered by the total sale price in descending order.
select a.full_name as Artist_name,sum(p.sale_price) as total_sale_price,count(w.work_id) as Total_work
from artist as a 
inner join work as w
on
a.artist_id=w.artist_id
inner join Product_size as p
on 
w.work_id=p.work_id
group by Artist_name
order by total_sale_price desc;




-- 6. Join, Group By, and Having:
-- List artists who have more than 3 works in the database, along with the count of their works.
select a.full_name as Artist_name,count(w.work_id) as total_work
from artist as a
inner join work as w 
on a.artist_id=w.artist_id
group by Artist_name
having total_work>3;



-- 7. Join, Where, and Order By:
-- Retrieve the names of works and their corresponding artists' full names for works that have a sale price smaller than their regular price. 
select Distinct(w.work_id), a.full_name as Artist_name,w.name as work_name
from work as w
inner join artist as a 
on w.artist_id=a.artist_id
inner join product_size as ps
on ps.work_id=w.work_id
where ps.sale_price < ps.regular_price;

select distinct(full_name) as Artist_name
from artist
order by Artist_name;




-- 8. Join, Group By, and Average:
-- Calculate the average height and width of the artworks in the database. Display the average height and width.

SELECT AVG(canvas_size.height) AS avg_height, AVG(canvas_size.width) AS avg_width
FROM canvas_size;



-- Join, Group By, and Max:
-- 9 Find the maximum sale price among all the works in each museum. Display the museum name along with the maximum sale price.
select w.name work, m.name as museum_name,max(ps.sale_price) as max_sale_price
from museum as m
inner join work as w 
on m.museum_id=w.museum_id
inner join  product_size as ps
on ps.work_id=w.work_id
group by museum_name,work
order by max_sale_price ;


-- Join, Group By, and Concatenate:
-- 10. Concatenate the first name and last name of artists along with their nationality, separated by a comma. Display the concatenated string along with the count of works by each artist, ordered by the count in descending order.
SELECT CONCAT(artist.first_name, ' ', artist.last_name, ', ', artist.nationality) AS artist_info, COUNT(work.work_id) AS work_count
FROM artist
JOIN work ON artist.artist_id = work.artist_id
GROUP BY artist.artist_id, artist.first_name, artist.last_name, artist.nationality
ORDER BY work_count DESC;




