use sakila;

-- Display full names of actors available in a database.

select concat(first_name,' ',last_name) as Full_Name from actor;

--  Number of times each firstname appears in a database

select first_name,count(first_name) as 'Repitition' from actor group by first_name order by  Repitition desc;

-- Actors having unique first names

select first_name,count(first_name) as 'Repitition' from actor group by first_name having count(first_name) =1 ;

-- Number of times each lastname appears in a database

select last_name,count(last_name) as 'Repitition' from actor group by last_name order by Repitition desc;

-- Actors having unique last names

select last_name,count(last_name) as 'Repitition' from actor group by Last_name having Repitition=1;

-- Films with rating 'R'

select title as 'Film_Name' from film where rating = 'R';

-- Films which are not rated as 'R'

select title as 'Film_Name',rating from film where rating !='R';

-- Films which are suitable for audiance below 13 years 

select title as 'Film_Nmae',rating from film where rating = 'G';

-- Films whose replacement cost is less than $11

select title as 'Film_Name', replacement_cost from film where replacement_cost <= 11 order by replacement_cost desc;

-- Films whose replacement cost is between $11 and $20

select title as 'Film_Name', replacement_cost from film where replacement_cost between 11 and 20 order by replacement_cost desc;

-- Films replaqcement cost in descinding order

select title as 'Film_Name', replacement_cost from film  order by replacement_cost desc;

--  Top 3 movies with the greatesr number of actors in them

select f.title,count(fa.actor_id) as 'No_actors' from film_actor fa join film f on 
fa.film_id = f.film_id group by f.film_id,f.title order by No_actors desc limit 3;

-- Film names starting with the letters 'Q' and 'K'

select title as 'Film_name' from film where title like 'k%' or  title like 'q%';

-- Names of all the actors who are in the film 'Agent Truman'

select concat(a.first_name,' ',last_name) as 'Full_Name' from film_actor fa join film f join actor a
on f.film_id = fa.film_id and fa.actor_id = a.actor_id where f.title = 'Agent Truman';

-- Names of all the family movies

select f.title as 'Film_Name' from category c join film_category fc join film f on c.category_id = fc.category_id and 
fc.film_id = f.film_id where c.name = 'family';

-- Displaying the maximum, minimum, and average rental rates of movies based on their ratings 
-- sorted in descending order of the average rental rates.

select rating,max(rental_rate) as max_rental_rate,min(rental_rate) as min_rental_rate,avg(rental_rate) as avg_rental_rate from film
group by rating order by avg_rental_rate desc;

-- Displaying the movies in descending order of their rental frequencies, so the management can maintain more copies of those movies.

select f.title as 'Film_Name',count(r.rental_id) as 'Rental_Frequency' from rental r join film f join inventory i  on 
r.inventory_id = i.inventory_id and f.film_id = i.film_id group by f.title order by count(r.rental_id) desc;

-- film categories, the difference between the average film replacement cost and the average film rental rate is greater than $15?
-- Displaying the list of film categories identified above,along with the corresponding average filmreplacement cost and average film rental rate

select c.name as 'category_name',avg(f.replacement_cost) as 'avg_replacement_cost',avg(f.rental_rate) as 'avg_rental_rate' 
from category c join film_category fc join film f on c.category_id  = fc.category_id and fc.film_id  = f.film_id 
group by c.name having abs(avg(f.replacement_cost) - avg(f.rental_rate)) > 15;

-- Film categories in which number of films is greater than 70

select c.name as 'category_name',count(fc.film_id) as 'Total_films' from category c join film_category fc on 
c.category_id = fc.category_id group by c.name having count(fc.film_id) > 70;
