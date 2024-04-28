--0/Creation of tables:

-- Creation of customer table:
CREATE TABLE customer (
    customerid INT PRIMARY KEY,
    customername VARCHAR(100),
    customertel number
);

-- Creation of product table:
CREATE TABLE product (
    productid INT PRIMARY KEY,
    productname VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Creation of ordres table:
CREATE TABLE ordres (
    customerid INT,
    productid INT,
    orderdate DATE,
    quantity INT,
    totalamount DECIMAL(10, 2),
    PRIMARY KEY (customerid, productid),
    FOREIGN KEY (customerid) REFERENCES customer(customerid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);
--1/Display all the data of customers :
SELECT * FROM customer;

--2/Display the product_name and category for products which their price is between 5000 and 10000:
SELECT productname, category FROM product WHERE price BETWEEN 5000 AND 10000;

--3/Display all the data of products sorted in descending order of price.
:
SELECT * FROM product ORDER BY price DESC;

--4/Display the total number of orders, the average amount,
--the highest total amount and the lower total amountFor each product_id, display the number of orders:
SELECT 
    COUNT(*) AS total_orders,
    AVG(totalamount) AS average_amount,
    MAX(totalamount) AS highest_total_amount,
    MIN(totalamount) AS lowest_total_amount,
    productid,
    COUNT(*) AS order_count_per_product
FROM ordres
GROUP BY productid;

--5/Display the customer_id which has more than 2 orders   :
SELECT customerid
FROM ordres
GROUP BY customerid
HAVING COUNT(*) > 2;

--6/For each month of the 2020 year, display the number of orders:
SELECT 
    EXTRACT(MONTH FROM orderdate) AS month,
    COUNT(*) AS orders_per_month
FROM ordres
WHERE EXTRACT(YEAR FROM orderdate) = 2020
GROUP BY EXTRACT(MONTH FROM orderdate);

--7/For each order, display the product_name, the customer_name and the date of the order:
SELECT 
    p.productname,
    c.customername,
    o.orderdate
FROM ordres o
JOIN product p ON o.productid = p.productid
JOIN customer c ON o.customerid = c.customerid;

--8/Display all the orders made three months ago :
SELECT *
FROM ordres
WHERE orderdate = DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

--9/Display customers (customer_id) who have never ordered a product:
SELECT c.customerid
FROM customer c
LEFT JOIN ordres o ON c.customerid = o.customerid
WHERE o.customerid IS NULL;
