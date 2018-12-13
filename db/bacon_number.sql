DROP TABLE films;
DROP TABLE actors;
DROP TABLE castings;

CREATE TABLE films
(
  id SERIAL8 primary key,
  title VARCHAR(255) NOT NULL,
);

CREATE TABLE actors
(
  id SERIAL8 primary key,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

CREATE TABLE castings
(
  id SERIAL8 primary key,
  film_id INT8 references films(id) ON DELETE CASCADE,
  actor_id INT8 references actors(id) ON DELETE CASCADE
);
