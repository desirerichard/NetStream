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