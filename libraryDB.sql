
CREATE DATABASE libraryDB;
GO

USE libraryDB;
GO

CREATE TABLE BORROWER (
	CardNo INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(255) NOT NULL,
	Address NVARCHAR(255) NOT NULL,
	Phone VARCHAR(50) NOT NULL
);
GO

CREATE TABLE LIBRARY_BRANCH (
	BranchID INT PRIMARY KEY IDENTITY(1,1),
	BranchName VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL
);
GO

CREATE TABLE PUBLISHER (
	PublisherID INT PRIMARY KEY IDENTITY(1,1),
	PublisherName NVARCHAR(255) NOT NULL 
	CONSTRAINT uk_Publisher UNIQUE (PublisherID, PublisherName),
	Address VARCHAR(255) NOT NULL,
	Phone VARCHAR(255) NOT NULL
);
GO

CREATE TABLE BOOKS(
	BookID INT PRIMARY KEY IDENTITY(1,1),
	Title NVARCHAR(255) NOT NULL,
	PublisherID INT FOREIGN KEY REFERENCES PUBLISHER (PublisherID) 
	ON UPDATE CASCADE ON DELETE CASCADE
);
GO

CREATE TABLE BOOK_AUTHORS (
	AuthorID INT PRIMARY KEY IDENTITY (1,1),
	BookId INT FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	AuthorName VARCHAR(255) NOT NULL, 
	CONSTRAINT UC_Book_Author UNIQUE (bookID, AuthorName)
);
GO

CREATE TABLE BOOK_COPIES (
	BookID INT FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT FOREIGN KEY REFERENCES LIBRARY_BRANCH(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	Number_Of_Copies INT NOT NULL
);
GO

CREATE TABLE BOOK_LOANS (
	BookID INT FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT FOREIGN KEY REFERENCES LIBRARY_BRANCH(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	CardNo INT FOREIGN KEY REFERENCES BORROWER(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	DateOut DATE NOT NULL,
	DateDue DATE NOT NULL
	--composite primary key
	PRIMARY KEY(BookID, BranchID, CardNo)
);
GO

INSERT INTO LIBRARY_BRANCH (BranchName, Address)
VALUES
       ('Central Library', '350 West Georgia St, Vancouver, BC V6B 6B1'), 
       ('Kitsilano Branch', '2425 Macdonald St, Vancouver, BC V6K 3Y9'),
       ('Collingwood Branch', '2985 Kingsway, Vancouver, BC V5R 5J4'),
       ('Surrey City Centre Branch', '10350 University Dr, Surrey, BC V3T 4B8'),
       ('Metrotown Branch', '6100 Willingdon Ave, Burnaby, BC V5H 4N5'), 
       ('Sharpstown Branch', '123 Main St, Sharpstown, BC V1X 2Y3');
GO

INSERT INTO BORROWER (Name, Address, Phone)
VALUES
	('John Smith', '123 Main St', '555-1234'), 
	('Jane Doe', '456 Elm St', '555-5678'), 
	('Bob Johnson', '789 Oak St', '555-9012'), 
	('Sara Lee', '1010 Cherry St', '555-3456'), 
	('Mike Brown', '111 Maple St', '555-7890'), 
	('Lisa Jones', '222 Cedar St', '555-2345'), 
	('Tommy Lee', '333 Pine St', '555-6789'), 
	('Kim Kim', '444 Walnut St', '555-1234');
GO

INSERT INTO PUBLISHER (PublisherName, Address, Phone)
VALUES
	('Penguin Random House', '1745 West Broadway, Vancouver, BC V6J 1Y2', '604-731-7827'), 
	('HarperCollins Publishers', '1950 Boundary Road, Burnaby, BC V5M 3Y7', '604-430-5711'), 
	('Simon & Schuster', '1230-200 Granville Street, Vancouver, BC V6C 1S4', '604-687-6878'), 
	('Hachette Book Group', '1950 Boundary Road, Burnaby, BC V5M 3Y7', '604-430-5711'), 
	('Macmillan Publishers', '100 College St, Toronto, ON M5G 1L5', '416-363-4343'), 
	('Scholastic Corporation', '90 Sherman Ave N, Hamilton, ON L8L 6L7', '905-523-1447'), 
	('Oxford University Press', '70 Wynford Dr, North York, ON M3C 1J9', '416-441-2941'), 
	('Pearson Education', '26 Prince Andrew Place, Don Mills, ON M3C 2T8', '416-447-5101'), 
	('Houghton Mifflin Harcourt', '125 High Street, Boston, MA 02110', '617-351-5000'), 
	('Bloomsbury Publishing', '1385 Broadway, New York, NY 10018', '646-307-5151');
GO

INSERT INTO BOOKS (Title)
VALUES
	('The Lost Tribe'), 
    ('To Kill a Mockingbird'), 
    ('1984'),
	('Animal Farm'),
    ('Brave New World'),
	('The Catcher in the Rye'),
    ('The Great Gatsby'),
	('One Hundred Years of Solitude'),
    ('Moby-Dick'),
	('Pride and Prejudice'),
    ('Jane Eyre'),
	('The Lost Tribe');
GO

INSERT INTO BOOK_LOANS (BookID, BranchID, CardNo, DateOut, DateDue)
VALUES
  (1, 1, 8, '2022-01-01', '2022-02-01'),
  (3, 2, 8, '2022-02-01', '2022-03-01'),
  (2, 3, 3, '2022-03-01', '2022-04-01'),
  (4, 4, 4, '2022-04-01', '2022-05-01'),
  (5, 5, 5, '2022-05-01', '2022-06-01'),
  (6, 1, 6, '2022-06-01', '2022-07-01'),
  (7, 2, 7, '2022-07-01', '2022-08-01'),
  (8, 3, 1, '2022-08-01', '2022-09-01');
GO

 INSERT INTO BOOK_AUTHORS (BookID, AuthorName)
VALUES
(1, 'Jane Austen'), 
(2, 'J.K. Rowling'), 
(3, 'Ernest Hemingway'), 
(4, 'Virginia Woolf'), 
(5, 'F. Scott Fitzgerald'), 
(6, 'Gabriel García Márquez'), 
(7, 'Herman Melville'), 
(8, 'Harper Lee'), 
(9, 'George Orwell'), 
(10, 'Aldous Huxley');
GO 

INSERT INTO BOOK_COPIES (Number_Of_Copies)
VALUES
(2), (4), (6), (8), (10), (12), (14), (16), (18), (20), (22), (24);
GO

SELECT * FROM 
((BOOK_LOANS 
FULL OUTER JOIN BORROWER 
ON BOOK_LOANS.CardNo = BORROWER.CardNo)
FULL OUTER JOIN BOOKS 
ON BOOK_LOANS.BookID = BOOKS.BookID)

--added records to the tables BOOK_LOANS and BORROWER
INSERT INTO BORROWER (Name, Address, Phone)
VALUES
	('Ana Smith', '133 Main St', '155-1234'), 
	('Al Doe', '156 Elm St', '155-5678'), 
	('Ali Johnson', '189 Oak St', '155-9012'), 
	('Tiara Lee', '1110 Cherry St', '155-3456');
GO

INSERT INTO BOOK_LOANS (BookID, BranchID, CardNo, DateOut, DateDue)
VALUES
  (9, 6, 9, '2023-01-01', '2023-02-01'),
  (10, 5, 10, '2023-02-01', '2023-03-01'),
  (11, 5, 11, '2023-03-01', '2023-04-01'),
  (12, 6, 12, '2023-04-01', '2023-05-01');
GO

INSERT INTO BOOK_LOANS (BookID, BranchID, CardNo, DateOut, DateDue)
VALUES
  (9, 6, 2, '2023-01-01', '2023-02-01');
GO

--executed the query again
SELECT * FROM 
((BOOK_LOANS 
FULL OUTER JOIN BORROWER 
ON BOOK_LOANS.CardNo = BORROWER.CardNo)
FULL OUTER JOIN BOOKS 
ON BOOK_LOANS.BookID = BOOKS.BookID)

--new query
USE libraryDB;
SELECT TOP 10 [Name], DateDue, Title FROM [dbo].[BOOK_LOANS]
LEFT JOIN[dbo].[BORROWER]
ON BORROWER.[CardNo] = BOOK_LOANS.CardNo
INNER JOIN[dbo].[BOOKS]
ON BOOK_LOANS.BookID = BOOKS.BookID
GO

--utilised aggregate functions
SELECT Name, AVG(CardNo) AS Card 
FROM DBO.BORROWER
WHERE CardNo > 1
	AND  CardNo != 2
	AND Name LIKE '%o%' OR Name LIKE '%a%'
GROUP BY NAME;
GO

SELECT 
AVG(Number_Of_Copies) AS avg_nr_copies, 
SUM(Number_Of_Copies) AS sum_nr_copies,
CAST(ROUND(STDEV(Number_Of_Copies), 2) AS DECIMAL(10, 2)) AS stdev_column_name,
MAX(Number_Of_Copies) - MIN(Number_Of_Copies) AS range,
MAX(Number_Of_Copies)%11 AS modulo
FROM BOOK_COPIES;

