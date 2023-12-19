# MLD

director (id_director, last_name, first_name)<br>   
film (id_film, title, duration, year, #id_director)<br>  
playing (id_playing, character_name, #id_actor, #id_film)<br>  
actor (id_actor, last_name, first_name, birthday)<br>  
watching (id_watching, favorite, #id_user, #id_film)<br>   
user (id_user, last_name, first_name, email, password, #id_role)<br>  
userRole (id_role, role_name)<br>  
