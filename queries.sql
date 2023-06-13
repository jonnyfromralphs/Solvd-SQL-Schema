INSERT INTO mydb.user (username, email, password, registration_date)
VALUES ('john_smith', 'jsmith@gmail.com', 'password', CURDATE());

INSERT INTO mydb.category (name, description)
VALUES ('Electronics', 'Electronic devices and accessories');

INSERT INTO mydb.product (name, description, price, stock_qty, category_id)
VALUES ('iPhone 15', 'Latest smartphone from Apple', 1599.99, 50, 1);

INSERT INTO mydb.address (address_line1, address_line2, city, state, zip_code)
VALUES ('123 Main St', 'Apt 4B', 'New York', 'NY', '10001');

INSERT INTO mydb.useraddress (user_id, address_id)
VALUES (4, 1);

INSERT INTO mydb.order (user_id, order_date, total_amount)
VALUES (4, CURDATE(), 1599.99);

INSERT INTO mydb.orderitem (order_id, product_id, qty, price)
VALUES (2, 1, 1, 1599.99);

INSERT INTO mydb.review (user_id, product_id, rating, comment)
VALUES (4, 1, 4.8, "The best");

INSERT INTO mydb.cart (cart_id, creation_date)
VALUES (1, CURDATE());

INSERT INTO mydb.usercart (user_id, cart_id)
VALUES (4, 1);

UPDATE mydb.user
SET password = 'newpassword'
WHERE user_id = 4;

UPDATE mydb.user
SET password = 'StrongerPassword123.'
WHERE user_id = 4;

UPDATE mydb.category
SET description = 'Electronic devices and accessories for everyone'
WHERE category_id = 1;

UPDATE mydb.product
SET stock_qty = 100
WHERE product_id = 1;

UPDATE mydb.product
SET stock_qty = 80
WHERE product_id = 1;

UPDATE mydb.address
SET address_line2 = '62'
WHERE address_id = 1;

UPDATE mydb.address
SET address_line1 = '72 S James St'
WHERE address_id = 1;

UPDATE mydb.review
SET rating = 3.0
WHERE review_id = 1;

UPDATE mydb.review
SET rating = 5.0
WHERE review_id = 1;

UPDATE mydb.review
SET comment = "The last phone I will ever buy"
WHERE review_id = 1;

ALTER TABLE mydb.user
ADD last_name varchar(255);

ALTER TABLE mydb.user
ADD first_name varchar(255);

ALTER TABLE mydb.address
ADD country varchar(100);

ALTER TABLE mydb.product
ADD on_sale TINYINT;

ALTER TABLE mydb.order
ADD express_shipping TINYINT;

DELETE FROM mydb.orderitem WHERE order_id = 2;
DELETE FROM mydb.order WHERE order_id = 2;
DELETE FROM mydb.review WHERE review_id = 2;
DELETE FROM mydb.usercart WHERE user_id = 4;
DELETE FROM mydb.useraddress WHERE user_id = 4;
DELETE FROM mydb.user WHERE user_id = 4;
DELETE FROM mydb.address WHERE address_id = 1;
DELETE FROM mydb.product WHERE product_id = 1;
DELETE FROM mydb.category WHERE category_id = 2;
DELETE FROM mydb.cart WHERE cart_id = 1;

SELECT u.username, SUM(o.order_amount) AS total_user_orders FROM mydb.user AS u
JOIN mydb.useraddress AS ua ON u.user_id = ua.user_id
JOIN mydb.address AS a ON ua.address_id = a.address_id
JOIN mydb.order AS o ON u.user_id = o.user_id
JOIN mydb.orderitem AS oi ON o.order_id = oi.order_id
JOIN mydb.product AS p ON oi.product_id = p.product_id
JOIN mydb.category AS c ON p.category_id = c.category_id
WHERE MONTH(o.order_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH);

SELECT * FROM mydb.product AS p
LEFT JOIN mydb.category AS c ON p.category_id = c.category_id;

SELECT * FROM mydb.product AS p
RIGHT JOIN mydb.category AS c ON p.category_id = c.category_id;

SELECT * FROM mydb.product AS p
INNER JOIN mydb.category AS c ON p.category_id = c.category_id;

SELECT * FROM mydb.user AS u
JOIN mydb.order AS o ON u.user_id = o.order_id;

SELECT * FROM mydb.user AS u
RIGHT JOIN mydb.order AS o ON u.user_id = o.order_id;

SELECT COUNT(user_id), username
FROM mydb.user
GROUP BY username
HAVING COUNT(user_id) > 2;

SELECT COUNT(user_id), registration_date
FROM mydb.user
GROUP BY registration_date
HAVING COUNT(user_id) > 5;

SELECT COUNT(user_id), username
FROM mydb.user
GROUP BY username
HAVING COUNT(user_id) > 2;

SELECT AVG(price) as avg_price
FROM mydb.product
GROUP BY category_id
HAVING avg_price > 1000;

SELECT SUM(price) as sum_price
FROM mydb.product
GROUP BY name
HAVING sum_price > 5000;

SELECT COUNT(zip_code)
FROM mydb.address
GROUP BY state
HAVING COUNT(address_id) > 5;

SELECT COUNT(order_id)
FROM mydb.order
GROUP BY order_date
HAVING COUNT(order_id) > 10;

SELECT COUNT(user_id), username
FROM mydb.user
GROUP BY username;

SELECT COUNT(user_id), registration_date
FROM mydb.user
GROUP BY registration_date;

SELECT COUNT(user_id), username
FROM mydb.user
GROUP BY username;

SELECT AVG(price) as avg_price
FROM mydb.product
GROUP BY category_id;

SELECT SUM(price) as sum_price
FROM mydb.product
GROUP BY name;

SELECT COUNT(zip_code)
FROM mydb.address
GROUP BY state;

SELECT COUNT(order_id)
FROM mydb.order
GROUP BY order_date;


