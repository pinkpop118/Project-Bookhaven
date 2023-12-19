Create Database bookwormhavenshop;

use bookwormhavenshop;

-- Table 1 BookInventory 
CREATE TABLE BookInventory ( 
    book_id INT PRIMARY KEY, 
    title VARCHAR(200) NOT NULL, 
    author VARCHAR(100) NOT NULL, 
    genre VARCHAR(50) NOT NULL, 
    publication_year INT NOT NULL, 
    price DECIMAL(10, 2) NOT NULL 
);

-- Table 2 Customers  
CREATE TABLE Customers ( 
    customer_id INT PRIMARY KEY, 
    full_name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) NOT NULL, 
    phone_number VARCHAR(20) NOT NULL, 
    is_chapter_chaser VARCHAR(3) NOT NULL, 
    points INT DEFAULT 0 
);

-- Table 3 Orders 
CREATE TABLE Orders ( 
    order_id INT PRIMARY KEY AUTO_INCREMENT, 
    customer_id INT, 
    total_amount_paid DECIMAL(10, 2) NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
);

-- Table 4 OrderItems
CREATE TABLE OrderItems ( 
    order_id INT, 
    book_id INT, 
    FOREIGN KEY (order_id) REFERENCES Orders(order_id), 
    FOREIGN KEY (book_id) REFERENCES BookInventory(book_id) 
);

-- Insert data into Customers table 
INSERT INTO Customers (customer_id, full_name, email, phone_number, is_chapter_chaser) 
VALUES  
    (301, 'Brian Ferris', 'ferris.b@gmail.com', '554 0034', 'Yes'), 
    (302, 'Jean Hopes', 'j.hopes123@hotmail.com', '468 2685', 'No'), 
    (303, 'Daryl Oats', 'Daryl@oats.com', '332 3661', 'Yes');
  
-- Insert data into BookInventory table 
INSERT INTO BookInventory (book_id, title, author, genre, publication_year, price) 
VALUES  
    (28001, 'The Left Hand of Darkness', 'Ursula K. Le Guin', 'Science Fiction', 1969, 7.00), 
    (28002, 'Metamorphosis', 'Franz Kafka', 'Fantasy Fiction', 1915, 7.99), 
    (28003, 'A Ghosts Tale', 'K.L Bentley', 'Horror', 2002, 9.99), 
    (28004, 'Hobbit World', 'Dob Wayne', 'Fantasy Fiction', 1996, 14.99); 
    
-- Placing an order for client 301 for books 28001 & 28004 
-- Insert data into Orders and OrderItems tables 
INSERT INTO Orders (customer_id, total_amount_paid) 
VALUES (301, (SELECT price FROM BookInventory WHERE book_id = 28001) + (SELECT price 
FROM BookInventory WHERE book_id = 28004)); 

INSERT INTO OrderItems (order_id, book_id) 
VALUES  
    (LAST_INSERT_ID(), 28001), 
    (LAST_INSERT_ID(), 28004);
    
       -- Update Chapter Chaser points for customer 301 
UPDATE Customers 
SET is_chapter_chaser = 'yes' 
WHERE customer_id = 301;

-- Placing an order for client 302 for books 28002 & 28003 
-- Insert data into Orders and OrderItems tables 
INSERT INTO Orders (customer_id, total_amount_paid) 
VALUES (302, (SELECT price FROM BookInventory WHERE book_id = 28002) + (SELECT price 
FROM BookInventory WHERE book_id = 28003));
 
INSERT INTO OrderItems (order_id, book_id) 
VALUES  
    (LAST_INSERT_ID(), 28002), 
    (LAST_INSERT_ID(), 28003);
    
    Select * from customers;
    select * from orders;
    select * from orderitems;
    
   
-- Update Chapter Chaser points for customer 301 
UPDATE Customers 
SET is_chapter_chaser = 'yes' 
WHERE customer_id = 301;
    
-- Placing an order for client 303 for 2 units of book 28004 
-- Insert data into Orders and OrderItems tables 
INSERT INTO Orders (customer_id, total_amount_paid) 
VALUES (303, (SELECT price FROM BookInventory WHERE book_id = 28004) + (SELECT price 
FROM BookInventory WHERE book_id = 28004)); 

INSERT INTO OrderItems (order_id, book_id) 
VALUES  
    (LAST_INSERT_ID(), 28004), 
    (LAST_INSERT_ID(), 28004); 
    
-- Update Chapter Chaser points for customer 303 
UPDATE Customers 
SET is_chapter_chaser = 'yes' 
WHERE customer_id = 303;

-- Placing an order for client 301 for books 28002 
-- Insert data into Orders and OrderItems tables 
INSERT INTO Orders (customer_id, total_amount_paid) 
VALUES (301, (SELECT price FROM BookInventory WHERE book_id = 28002)); 

INSERT INTO OrderItems (order_id, book_id) 
VALUES  
    (LAST_INSERT_ID(), 28002);
    
    -- Update Chapter Chaser points for customer 301 
UPDATE Customers 
SET is_chapter_chaser = 'yes' 
WHERE customer_id = 301;
    
    select * from customers;
    
    UPDATE Customers AS c 
JOIN Orders AS o ON c.customer_id = o.customer_id 
SET c.points = c.points + (o.total_amount_paid * 100) 
WHERE c.is_chapter_chaser = 'yes';

-- Aggregate functions
SELECT SUM(total_amount_paid) 
AS total_amount_paid_total
FROM Orders;

Select count(order_id)
as All_Orders
from orderitems;

select AVG(total_amount_paid)
AS total_amount_paid_avg
from orders;

select min(total_amount_paid) as cheapest_order, Max(total_amount_paid) as Expensive_order
from orders;

