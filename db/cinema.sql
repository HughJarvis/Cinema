DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR,
  price INT
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  funds INT
);

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  start_time VARCHAR,
  seats_available INT,
  seats_sold INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  screening_id INT REFERENCES screenings(id) ON DELETE CASCADE
);
