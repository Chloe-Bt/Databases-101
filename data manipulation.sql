-- GROUP BY, HAVING: Which shops have more than 5 of the book 'The Hobbit' in stock?
SELECT '<query 1>';
SELECT BS.name, BS.address, B.title, S.stock FROM Bookshop BS 
	JOIN Stocks S ON BS.address = S.address
    JOIN Book B ON S.isbn = B.isbn
    WHERE B.title = 'The Hobbit'
    GROUP BY BS.address HAVING stock > 5;

-- Set operation: Compute the names of the employees who have a manager function.
SELECT '<query 2>';
SELECT E.name FROM Employee E
    WHERE employeeID IN (SELECT employeeID 
        FROM Employee
        INTERSECT
        SELECT employeeID FROM Contract
            WHERE function = 'manager');


-- Nested query: Which books have the same genre as 'Good Omens'?
SELECT '<query 3>';
SELECT B.title FROM Book B 
	JOIN BookGenre BG ON B.isbn = BG.isbn
	WHERE bg.genreID IN 
    	(SELECT BG.genreID FROM BookGenre BG 
     		WHERE BG.isbn IN 
     			(SELECT B.isbn FROM Book B 
                 	WHERE B.title = 'Good Omens')
    );

-- Aggregation: Find the titles and authors of the books with more than one author.
SELECT '<query 4>';
SELECT B.title, A.name FROM Author A, Book B, BookAuthor BA
    WHERE B.isbn = BA.isbn
    AND A.authorID = BA.authorID
    AND BA.isbn IN (
        SELECT isbn
        FROM BookAuthor
        GROUP BY isbn
        HAVING COUNT(authorID) >= 2
    );

-- Query over multiple tables (JOIN): Which employees have a contract at the shop in Booktown?
SELECT '<query 5>';
SELECT E.employeeID, E.name FROM Employee E
    JOIN Contract C ON C.employeeID = E.employeeID
    WHERE C.address LIKE '%Booktown';


-- LIKE (string matching): Compute the title of every book beginning with "The".
SELECT '<query 6>';
SELECT B.title
    FROM Book B
    WHERE B.title LIKE 'The%';