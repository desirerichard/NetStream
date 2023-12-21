# NetStream
NetStream is a dynamic streaming platform offering an extensive library of movies, TV shows, documentaries and exclusive content.

### SQL Requests


Titles and release dates of films from the most recent to the oldest :

```sql
SELECT title, year_date from film
ORDER by year_date DESC
```

The names, first names and ages of actors/actresses over 30 years in alphabetical order :
```sql
SELECT last_name, first_name, birthday from actor
WHERE birthday < '1993-12-31'
ORDER by last_name
```

The list of main actors/actresses for a given film :
```sql
SELECT A.last_name, A.first_name
FROM Actor A
JOIN Playing P ON A.id_actor = P.id_actor
JOIN Film F ON P.id_film = F.id_film
WHERE F.title = 'Inception';
```

A list of movies featuring a specific actor/actress :
```sql
SELECT F.title
FROM Film F
JOIN Playing P ON F.id_film = P.id_film
JOIN Actor A ON A.id_actor = P.id_actor
where A.last_name = 'DiCaprio' AND A.first_name = 'Leonardo';
```

Add a film :
```sql
INSERT INTO Film (title, duration, year_date, id_director) VALUES
('Once Upon a Time in Hollywood', 161, 2019, 3);
```

Add an actor/actress :
```sql
INSERT INTO Actor (last_name, first_name, birthday) VALUES
('Amelio', 'Austin', '1988-04-27');
```

Edit a film :
```sql
UPDATE Film
SET title = 'Arthur', duration = '120'
WHERE id_film = 7;
```

Delete an actor/actress :
```sql
DELETE FROM Actor WHERE last_name='Amelio';
```

Show last 3 actors/actresses added :
```sql
SELECT * from actor
ORDER by id_actor DESC LIMIT 3
```