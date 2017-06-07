DROP TABLE IF EXISTS pizza_orders;
DROP TABLE IF EXISTS customers;
-- Note: make sure you use the DROP TABLE in the correct order, the order should be in which order the tables tie into each other(ie if customers table refed pizza_orders then it would need to drop first.).

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE pizza_orders (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  topping VARCHAR(255),
  quantity INT2,
  customer_id INT4 REFERENCES customers(id)
);
