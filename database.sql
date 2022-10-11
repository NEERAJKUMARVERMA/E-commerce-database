CREATE TABLE customer (
	cust_id INT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	dob DATE NOT NULL,
	gender VARCHAR(1) NOT NULL,
	primary_address INT,
	primary_phone INT,
	primary_email INT,
	primary_payment INT
    );


INSERT INTO customer VALUES (1001,'Sadhna','Devadi','1986-11-23','F',NULL,NULL,NULL,NULL),		
(1002,'Mukesh','Yadav','1987-3-23','M',NULL,NULL,NULL,NULL),
(1003,'Arun','Kumar','1991-10-6','M',NULL,NULL,NULL,NULL),
(1004,'Neeta','Kumari','1989-8-16','F',NULL,NULL,NULL,NULL),
(1005,'Anil','Singh','1996-8-19','M',NULL,NULL,NULL,NULL);

select * from customer;


CREATE TABLE phone (
phone_id INT PRIMARY KEY,
cust_id INT NOT NULL,
country_code INT NOT NULL,
area_code INT NOT NULL,
phone_number INT NOT NULL,
phone_type VARCHAR(8) NOT NULL,
FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE
);

INSERT INTO phone VALUES (10001,1001,1,531,2836774,'Mobile'),
(10002,1001,1,531,7705843,'Work'),
(10003,1001,1,531,7708465,'Fax'),
(10004,1002,1,203,7796292,'Mobile'),
(10005,1003,1,971,6526066,'Mobile'),
(10006,1004,1,554,7741089,'Mobile'),
(10007,1005,1,566,3043971,'Mobile');

select * from phone;

alter table phone add primary_phone varchar(20);
update phone set primary_phone='TRUE' where phone_id=10001;
update phone set primary_phone='FALSE' where phone_id=10002;
update phone set primary_phone='FALSE' where phone_id=10003;
update phone set primary_phone='TRUE' where phone_id=10004;
update phone set primary_phone='TRUE' where phone_id=10005;
update phone set primary_phone='TRUE' where phone_id=10006;
update phone set primary_phone='TRUE' where phone_id=10007;


UPDATE customer
SET primary_phone = 10001
WHERE cust_id = 1001;

UPDATE customer
SET primary_phone = 10004
WHERE cust_id = 1002;

UPDATE customer
SET primary_phone = 10005
WHERE cust_id = 1003;

UPDATE customer
SET primary_phone = 10006
WHERE cust_id = 1004;

UPDATE customer
SET primary_phone = 10007
WHERE cust_id = 1005;

ALTER TABLE CUSTOMER
ADD FOREIGN KEY(primary_phone)
REFERENCES phone(phone_id);

CREATE TABLE email (
email_id INT PRIMARY KEY,
cust_id INT NOT NULL,
email VARCHAR(254) NOT NULL,
email_type VARCHAR(10) NOT NULL,
primary_email VARCHAR(10) NOT NULL,
FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE
);

INSERT INTO email VALUES (10001,1001,'sadhna123@gmail.com','Personal', 'TRUE'),
(10002,	1001,'devadi.macrosoft@gmail.com','Work', 'FALSE'),
(10003,	1002,'mukesh2323@gmail.com','Personal', 'TRUE'),
(10004,	1002,'dps123@gmail.com','School', 'FALSE'),
(10005,	1003,'arun106@gmail.com','Personal', 'TRUE'),
(10006,	1004,'neeta16@gmail.com','Personal', 'TRUE'),
(10007,	1005,'anilsingh96@gmail.com','Personal', 'TRUE');

select * from email;

UPDATE customer
SET primary_email = 10001
WHERE cust_id = 1001;

UPDATE customer
SET primary_email = 10003
WHERE cust_id = 1002;

UPDATE customer
SET primary_email = 10005
WHERE cust_id = 1003;

UPDATE customer
SET primary_email = 10006
WHERE cust_id = 1004;

UPDATE customer
SET primary_email = 10007
WHERE cust_id = 1005;
COMMIT;

ALTER TABLE customer
ADD FOREIGN KEY(primary_email)
REFERENCES email(email_id);

CREATE TABLE payment (
payment_id INT PRIMARY KEY,
cust_id INT NOT NULL,
cc_number VARCHAR(16) NOT NULL,
cc_type VARCHAR(20) NOT NULL,
cc_name_different VARCHAR(100),
cc_exp_month INT NOT NULL,
cc_exp_year INT NOT NULL,
primary_payment VARCHAR NOT NULL,
FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE
);


alter table payment drop column primary_payment;
alter table payment add primary_payment varchar(20);
INSERT INTO payment VALUES (100001,1001,3685446237952037,'Rupay',NULL,11,2022,'TRUE'),
(100002,1002,493751514954950,'Visa',NULL,9,2024, 'TRUE'),
(100003,1003,4808437630180081,'Visa',NULL,1,2023, 'TRUE'),
(100004,1004,4828526348154572,'Visa',NULL,4,2023, 'TRUE'),
(100005,1005,4248168108403535,'Visa',NULL,12,2020, 'TRUE');

select * from payment;

UPDATE customer
SET primary_payment = 100001
WHERE cust_id = 1001;

UPDATE customer
SET primary_payment = 100002
WHERE cust_id = 1002;

UPDATE customer
SET primary_payment = 100003
WHERE cust_id = 1003;

UPDATE customer
SET primary_payment = 100004
WHERE cust_id = 1004;

UPDATE customer
SET primary_payment = 100005
WHERE cust_id = 1005;

ALTER TABLE customer
ADD FOREIGN KEY(primary_payment)
REFERENCES payment(payment_id);

CREATE TABLE address (
address_id INT PRIMARY KEY,
cust_id INT NOT NULL,
address VARCHAR(100) NOT NULL,
city VARCHAR(20) NOT NULL,
state VARCHAR(20) NOT NULL,
pin_code INT NOT NULL,
country VARCHAR(20) NOT NULL,
address_type VARCHAR(10) NOT NULL,
primary_address VARCHAR(10) NOT NULL,
FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE
);


INSERT INTO address VALUES (1001,1001,'Civil line','Prayagraj','U.P',209601,'INDIA','Home','TRUE'),
(1002,1001,'Kankarbagh','Patna','Bihar',800020,'INDIA','Work','FALSE'),
(1003,1002,'Manpur patwatoli','Gaya','Bihar',823003,'INDIA','Home','TRUE'),
(1004,1003,'Kalyanpur','Kanpur','U.P',208016,'INDIA','Home','TRUE'),
(1005,1004,'connaught place','New delhi','Delhi',110001,'INDIA','Home','TRUE'),
(1006,1005,'Faizabadh road','Lucknow','U.P',224001,'INDIA','Home','TRUE');

select * from address;

UPDATE customer
SET primary_address = 1001
WHERE cust_id = 1001;

UPDATE customer
SET primary_address = 1003
WHERE cust_id = 1002;

UPDATE customer
SET primary_address = 1004
WHERE cust_id = 1003;

UPDATE customer
SET primary_address = 1005
WHERE cust_id = 1004;

UPDATE customer
SET primary_address = 1006
WHERE cust_id = 1005;

ALTER TABLE customer
ADD FOREIGN KEY(primary_address)
REFERENCES address(address_id);

CREATE TABLE order_details (
order_id INT PRIMARY KEY,
cust_id INT NOT NULL,
cart_id INT,
payment_id INT NOT NULL,
payment_date DATE,
order_date DATE NOT NULL,
ship_date DATE,
ship_method VARCHAR(30) NOT NULL,
cancellation_date DATE,
return_date DATE,
FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE,
FOREIGN KEY(payment_id) REFERENCES payment(payment_id)
);


INSERT INTO order_details VALUES 
(1000001,1001,NULL,100001,'2019-12-20','2019-12-20','2019-12-20','Xpressbess',NULL,'2019-12-27'),
(1000002,1001,NULL,100001,'2020-2-1','2020-1-29','2020-2-1','Bluedart express',NULL,NULL),
(1000003,1001,NULL,100001,'2020-3-1','2020-3-1','2020-3-1','Bluedart express', NULL, NULL),		
(1000004,1002,NULL,100002,'2019-4-1','2019-4-1','2019-4-2','Ecom express',NULL,'2019-4-7'),		
(1000005,1003,NULL,100003,'2019-5-7','2019-5-7','2019-5-7','Fedex',NULL,NULL),		
(1000006,1004,NULL,100004,'2019-3-8','2019-3-8','2019-3-10','Ecom express','2019-3-15',NULL),
(1000007,1005,NULL,100005,'2020-5-20','2020-5-20','2020-5-21','Fedex',NULL, NULL);

select * from order_details;

CREATE TABLE cart (
cart_id INT PRIMARY KEY,
order_id INT NOT NULL,
product_id INT,
discount INT,
FOREIGN KEY(order_id) REFERENCES order_details(order_id) ON DELETE CASCADE
);


INSERT INTO cart VALUES 
(1000011,1000001,NULL,NULL),
(1000012,1000002,NULL,NULL),	
(1000013,1000003,NULL,NULL),	
(1000014,1000004,NULL,NULL),	
(1000015,1000005,NULL,NULL),	
(1000016,1000006,NULL,NULL),	
(1000017,1000007,NULL,NULL);

select * from cart;

UPDATE order_details
SET cart_id = 1000011
WHERE order_id = 1000001;

UPDATE order_details
SET cart_id = 1000012
WHERE order_id = 1000002;

UPDATE order_details
SET cart_id = 1000013
WHERE order_id = 1000003;

UPDATE order_details
SET cart_id = 1000014
WHERE order_id = 1000004;

UPDATE order_details
SET cart_id = 1000015
WHERE order_id = 1000005;

UPDATE order_details
SET cart_id = 1000016
WHERE order_id = 1000006;

UPDATE order_details
SET cart_id = 1000017
WHERE order_id = 1000007;

ALTER TABLE order_details
ADD FOREIGN KEY(cart_id)
REFERENCES cart(cart_id);


CREATE TABLE product_catalog (
product_id INT PRIMARY KEY,
product_name VARCHAR(50) NOT NULL,
vendor_id INT NOT NULL,
manufacturer_id VARCHAR(10) NOT NULL,
color_id INT,
size_id INT,
unit_id INT,
price_per_unit INT,
weight_per_unit INT
);


INSERT INTO product_catalog VALUES 
(10000000,'Desktop computer',1001,'Dell',1,2,1,100000,10),
(10000001,'Laptop Computer',1001,'Dell',1,1,1,80000,3),
(10000002,'Laptop Computer',1002,'Apple',2,1,1,120000,3),
(10000003,'Laptop Computer',1003,'Acer',1,1,1,50000,3),
(10000004,'Laptop Computer',1004,'Lenovo',1,1,1,40000,3);

select * from product_catalog;

UPDATE cart
SET product_id = 10000002
WHERE cart_id = 1000011;

UPDATE cart
SET product_id = 10000002
WHERE cart_id = 1000012;

UPDATE cart
SET product_id = 10000002
WHERE cart_id = 1000013;

UPDATE cart
SET product_id = 10000003
WHERE cart_id = 1000014;

UPDATE cart
SET product_id = 10000002
WHERE cart_id = 1000015;

UPDATE cart
SET product_id = 10000004
WHERE cart_id = 1000016;

UPDATE cart
SET product_id = 10000000
WHERE cart_id = 1000017;

ALTER TABLE cart
ADD FOREIGN KEY(product_id)
REFERENCES product_catalog(product_id);
