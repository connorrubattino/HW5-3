--1. List all customers with their address who live in Texas (use JOINs)
SELECT first_name, last_name, address
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id
WHERE district = 'Texas';


--2. List all payments of more than $7.00 with the customer’s first and last name
SELECT first_name, last_name, payment_id, amount
FROM customer c 
JOIN payment p
ON c.customer_id = p.customer_id 
WHERE amount > 7;


--3. Show all customer names who have made over $175 in payments (use
--subqueries)
SELECT first_name, last_name
FROM customer c 
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);


--4. List all customers that live in Argentina (use multiple joins)
SELECT first_name, last_name
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id
JOIN city c2 
ON a.city_id = c2.city_id 
JOIN country c3 
ON c2.country_id = c3.country_id
WHERE country = 'Argentina';


--5. Show all the film categories with their count in descending order
SELECT "name", count(title)
FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id 
JOIN film f 
ON fc.film_id = f.film_id 
GROUP BY "name"
ORDER BY count(title) DESC;



--6. What film had the most actors in it (show film info)?
SELECT title, description, rating
FROM film_actor fa
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY title, description, rating
ORDER BY COUNT(actor_id) DESC
LIMIT 1;


--7. Which actor has been in the least movies?
SELECT a.first_name, a.last_name, count(*) AS num_films
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY a.first_name, a.last_name
ORDER BY count(*) ASC 
LIMIT 1;


--8. Which country has the most cities?
SELECT country, c.country_id, count(*) 
FROM country c 
JOIN city c2 
ON c.country_id = c2.country_id 
GROUP BY country, c.country_id 
ORDER BY count(*) DESC 
LIMIT 1;



--9. List the actors who have been in between 20 and 25 films.
SELECT a.actor_id, a.first_name, a.last_name, count(*)
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING count(*) >= 20 AND count(*) <= 25;