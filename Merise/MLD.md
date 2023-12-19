# MLD

director (id_director, last_name, first_name)   
film (id_film, title, duration, year, #id_director)
playing (id_playing, character_name, #id_actor, #id_film) 
actor (id_actor, last_name, first_name, birthday)
watching (id_watching, favorite, #id_user, #id_film)  
user (id_user, last_name, first_name, email, password, #id_role)  
userRole (id_role, role_name)