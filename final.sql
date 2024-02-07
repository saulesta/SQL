######################################################################
###
###		Student
###			name: Saule
###			surname: Staneviciute
###
#######################################################################

/* 
*	EXERCISE 01: 
*	Pateikite tik tuos mokėjimus, kurių vertė (amount) yra didesnė nei 2. 
*   Naudokite lentelę payment.
*/
	select *
    from sakila.payment
    where amount > 2;
	
    
/* 
*	EXERCISE 02: 
*	Submit movies with a rating of PG and a replacement_cost of less than 10.
*/
	select *
    from sakila.film
    where rating like 'PG' AND replacement_cost < 10;
    
    
/* 
*	EXERCISE 03: 
*	Calculate the average rental rate (rental_rate) for movies in each rating, with only 2 decimal numbers.
*/
	select rating, truncate(avg(rental_rate), 2) as 'average rental price'
    from sakila.film
    group by rating;
    
    
/* 
*	EXERCISE 04: 
*	Print the names of all customers (first_name), and next to the first_name column, count the length of each name (how many letters are in the name).
*/
	select first_name as 'client name', length(first_name) as 'name length'
    from sakila.customer;
    
    
/* 
*	EXERCISE 05: 
*	Explore which letter is "e" in the description of each movie.
*/    
    select description as 'description', locate('e',description) as 'which letter is „e“'
    from sakila.film;
    
    
/* 
*	EXERCISE 06: 
*	Add up the total length of movies for each rating.
*   Print only ratings with a total length of movies greater than 22000.
*/   
	select rating, sum(length) as 'total film length'
    from sakila.film
    group by rating
    having sum(length) > 22000;

    
    
    
/* 
*	EXERCISE 07: 
*	Print the descriptions of all movies, next to them print the number of elements that make up the descriptions (character numbers). 
*   In the third column, print the number of items in the descriptions, changing all the letters "a" to "OO" in them.
*/ 
	
    select description, length(description) as 'element number' , replace(description, 'a' , 'OO') as 'all letters „a“ replaced to „OO“' , LENGTH(replace(description, 'a' , 'OO')) as 'new object element number'
    from sakila.film_text;
    
/* 
*	EXERCISE 08: 
*	Write an SQL query that sorts movies according to their ratings (rating)
*   into the following categories:
*      If the rating is "PG" or "G" then "PG_G"
*      If the rating is "NC-17" or "PG-13" then "NC-17-PG-13"
*      Put all other ratings in the "Irrelevant" category
*   Display the categories in the "Rating_group" column
*/ 
	select rating,
    CASE
    WHEN rating in ('PG','G') then 'PG_G'
    WHEN rating in ('NC-17', 'PG-13') then 'NC-17-PG-13'
    ELSE 'Irrelevant'
    END AS rating_group
    from sakila.film
    group by rating;
    

    
    
/* 
*	EXERCISE 09: 
*	Sum the rental duration (rental_duration) for each movie for category (home).
*      Print only those categories that have a rental_duration amount greater than 300.
*   Complete the task by combining the tables.
*/ 
	
    select sum(rental_duration) as 'rental duration', c.name as 'film category'
    from sakila.film f
    join sakila.film_category fc on f.film_id = fc.film_id
    join sakila.category c on fc.category_id = c.category_id
    group by c.name
    having sum(rental_duration) > 300;
    
    
    
/* 
*	EXERCISE 10: 
*	Provide the first_name (first_name) and last_name (last_name) of the customers who
*   rented the movie "AGENT TRUMAN". Perform the task using a subquery.
*/ 
	
select first_name 'client name', last_name as 'client surname'
from sakila.customer
where customer_id in (select customer_id from sakila.rental where inventory_id in (select inventory_id from sakila.inventory where film_id = 6));


  
    
    