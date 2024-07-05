CREATE DATABASE library;
Drop database library;
USE library;


CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);


CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);


CREATE TABLE Books (
    ISBN VARCHAR(155) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);


CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);


CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(155),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);


CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(155),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);


INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123 Main St, CityA', '1234567890'),
(2, 102, '456 Elm St, CityB', '0987654321');


INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'Alice', 'Manager', 75000, 1),
(102, 'Bob', 'Manager', 72000, 2),
(103, 'Charlie', 'Assistant', 45000, 1),
(104, 'David', 'Clerk', 30000, 2),
(105, 'Eve', 'Assistant', 48000, 1),
(106, 'Frank', 'Clerk', 32000, 1),
(107, 'Grace', 'Assistant', 50000, 2);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-3-16-148410-0', 'The Great Gatsby', 'Fiction', 20.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-1-40-289462-6', 'To Kill a Mockingbird', 'Fiction', 18.00, 'no', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-14-044913-6', 'The Iliad', 'History', 25.00, 'yes', 'Homer', 'Penguin Classics'),
('978-0-19-953556-9', '1984', 'Dystopian', 15.00, 'yes', 'George Orwell', 'Secker & Warburg'),
('978-0-7432-7356-5', 'A Brief History of Time', 'Science', 30.00, 'no', 'Stephen Hawking', 'Bantam Books'),
('978-0-451-52493-5', 'Fahrenheit 451', 'Dystopian', 22.00, 'yes', 'Ray Bradbury', 'Ballantine Books');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'John Doe', '789 Maple St, CityA', '2021-12-15'),
(2, 'Jane Smith', '101 Oak St, CityB', '2022-02-20'),
(3, 'Emily Davis', '202 Birch St, CityA', '2020-10-10'),
(4, 'Michael Brown', '303 Pine St, CityB', '2023-05-25'),
(5, 'Jessica Wilson', '404 Cedar St, CityA', '2023-06-10');


INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 1, 'The Great Gatsby', '2023-06-15', '978-3-16-148410-0'),
(2, 3, 'The Iliad', '2023-05-20', '978-0-14-044913-6'),
(3, 5, '1984', '2023-06-12', '978-0-19-953556-9');


INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 1, 'The Great Gatsby', '2023-06-25', '978-3-16-148410-0'),
(2, 3, 'The Iliad', '2023-06-10', '978-0-14-044913-6');

-- 1.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. 
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. 
SELECT Books.Book_title, Customer.Customer_name
FROM Books
JOIN IssueStatus ON Books.ISBN = IssueStatus.Isbn_book
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

-- 4. 
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- 5. 
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. 
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. 
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. 
SELECT Customer_name
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. 
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- 10. 
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- 11. 
SELECT Employee.Emp_name, Branch.Branch_address
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

-- 12. 
SELECT DISTINCT Customer.Customer_name
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
WHERE Books.Rental_Price > 25;
