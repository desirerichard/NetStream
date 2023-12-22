-- Create tables

CREATE TABLE IF NOT EXISTS UserRole (
    id_role SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS UserTable (
    id_user SERIAL PRIMARY KEY,
    last_name VARCHAR(100),
    first_name VARCHAR(100),
    email VARCHAR(250) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    id_role INT,
    FOREIGN KEY (id_role) REFERENCES UserRole(id_role)
);

CREATE TABLE IF NOT EXISTS Director (
    id_director SERIAL PRIMARY KEY,
    last_name VARCHAR(100),
    first_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Film (
    id_film SERIAL PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    duration INT,
    year_date NUMERIC(4,0) CHECK (year_date >= 1000 AND year_date <= 3000),
    id_director INT,
    FOREIGN KEY (id_director) REFERENCES Director(id_director)
);

CREATE TABLE IF NOT EXISTS Watching (
    id_watching SERIAL PRIMARY KEY,
    favorite BOOLEAN,
    id_user INT,
    id_film INT,
    FOREIGN KEY (id_user) REFERENCES UserTable(id_user),
    FOREIGN KEY (id_film) REFERENCES Film(id_film)
);

CREATE TABLE IF NOT EXISTS Actor (
    id_actor SERIAL PRIMARY KEY,
    last_name VARCHAR(100),
    first_name VARCHAR(100),
    birthday date
);

CREATE TABLE IF NOT EXISTS Playing (
    id_playing SERIAL PRIMARY KEY,
    character_name VARCHAR(100),
    id_actor INT,
    id_film INT,
    FOREIGN KEY (id_actor) REFERENCES Actor(id_actor),
    FOREIGN KEY (id_film) REFERENCES Film(id_film)
);


-- Create Admin_Database
CREATE USER admin_database WITH PASSWORD 'admin_database_password';

GRANT ALL PRIVILEGES ON DATABASE postgres TO admin_database;

REVOKE ALL PRIVILEGES ON DATABASE postgres FROM PUBLIC;



-- Add datas

-- Add admin & visitor roles
INSERT INTO UserRole (role_name) VALUES ('admin'); 
INSERT INTO UserRole (role_name) VALUES ('visitor');


-- Create first user (visitor )
INSERT INTO UserTable (last_name, first_name, email, password, id_role)
VALUES ('Dupont', 'Jean-Jacques', 'jeanjacquesdupont@google.com', 'password', (SELECT id_role FROM UserRole WHERE role_name = 'visitor'));

-- Create second user (admin)
INSERT INTO UserTable (last_name, first_name, email, password, id_role)
VALUES ('AdminLastname', 'AdminFirstname', 'admin@google.com', 'adminpassword', (SELECT id_role FROM UserRole WHERE role_name = 'admin'));

-- Create third user (visitor)
INSERT INTO UserTable (last_name, first_name, email, password, id_role)
VALUES ('Roger', 'Yves', 'yves-roger@hotmail.com', 'password', (SELECT id_role FROM UserRole WHERE role_name = 'visitor'));

-- Add Directors
INSERT INTO Director (last_name, first_name) VALUES
('Nolan', 'Christopher'),
('Darabont', 'Frank'),
('Tarantino', 'Quentin'),
('Nolan', 'Christopher'),
('Zemeckis', 'Robert'),
('Cameron', 'James');

-- Add Films
INSERT INTO Film (title, duration, year_date, id_director) VALUES
('Inception', 148, 2010, 1),
('The Shawshank Redemption', 142, 1994, 2),
('Pulp Fiction', 154, 1994, 3),
('The Dark Knight', 152, 2008, 4),
('Forrest Gump', 142, 1994, 5),
('Titanic', 195, 1997, 6);

-- Add Actors
INSERT INTO Actor (last_name, first_name, birthday) VALUES
('DiCaprio', 'Leonardo', '1974-11-01'),
('Robbins', 'Tim', '1958-10-16'),
('Travolta', 'John', '1954-02-18'),
('Ledger', 'Heath', '1979-04-04'),
('Hanks', 'Tom', '1956-07-09'),
('Holland', 'Tom', '1996-06-01'),
('Cillian', 'Murphy', '1976-05-25');

-- Add Characters
INSERT INTO Playing (character_name, id_actor, id_film) VALUES
('Dom Cobb', 1, 1),
('Andy Dufresne', 2, 2),
('Vincent Vega', 3, 3),
('The Joker', 4, 4),
('Forrest Gump', 5, 5),
('Jack', 1, 6),
('Robert Fisher', 7, 1);

-- Add Watching datas
INSERT INTO Watching (favorite, id_user, id_film) VALUES
(true, 1, 1),
(false, 1, 5),
(true, 1, 3),
(false, 3, 1),
(false, 3, 4),
(true, 3, 3),
(true, 2, 1),
(false, 2, 2);

-- Advanced

-- Create or replace a stored procedure to a films list by a given director
CREATE OR REPLACE FUNCTION Get_Films_by_Director(director_full_name VARCHAR(200))
RETURNS TABLE(title VARCHAR(250), duration INT, year_date NUMERIC)
AS $$
BEGIN
    RETURN QUERY
    SELECT Film.title, Film.duration, Film.year_date
    FROM Film
    JOIN Director ON Film.id_director = Director.id_director
    WHERE CONCAT(Director.first_name, ' ', Director.last_name) = director_full_name;
    IF NOT FOUND THEN
    RAISE EXCEPTION 'Director not found: %', director_full_name;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Create an update table to store changes
CREATE TABLE IF NOT EXISTS UserTable_Update (
    id_update SERIAL PRIMARY KEY,
    id_user INT,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_last_name VARCHAR(100),
    new_last_name VARCHAR(100),
    old_first_name VARCHAR(100),
    new_first_name VARCHAR(100),
    old_email VARCHAR(250),
    new_email VARCHAR(250),
    old_password VARCHAR(50),
    new_password VARCHAR(50),
    id_role INT,
    FOREIGN KEY (id_user) REFERENCES UserTable(id_user)
);

-- Create trigger function
CREATE OR REPLACE FUNCTION user_table_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO UserTable_Update (
        id_user,
        old_last_name, new_last_name,
        old_first_name, new_first_name,
        old_email, new_email,
        old_password, new_password,
        id_role
    ) VALUES (
        OLD.id_user,
        OLD.last_name, NEW.last_name,
        OLD.first_name, NEW.first_name,
        OLD.email, NEW.email,
        OLD.password, NEW.password,
        OLD.id_role
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger on UserTable
CREATE TRIGGER user_table_trigger
AFTER UPDATE ON UserTable
FOR EACH ROW
EXECUTE FUNCTION user_table_update();
