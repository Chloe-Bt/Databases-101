-- GROUP BY, HAVING: Which shops have more than 5 of the book 'The Hobbit' in stock?
SELECT '<query 1>';
Select bs.name, bs.address, b.title, s.stock from Bookshop bs 
	join Stocks s on bs.address = s.address
    Join Book b on  s.isbn = b.isbn
    where b.title = 'The Hobbit'
    group by bs.address having stock > 5;


-- Set operation (UNION, INTERSECT, EXCEPT)
-- Compute the names of the employees who have a manager function.
SELECT '<query 2>';
SELECT name FROM Employee
INTERSECT
SELECT employeeID FROM Contract
    Where function = 'manager';

-- Nested query: books with the same genre as 'Good Omens'?
SELECT '<query 3>';
SELECT b.title from Book b 
	join BookGenre bg on b.isbn = bg.isbn
	where bg.genreID in 
    	(SELECT bg.genreID from BookGenre bg 
     		where bg.isbn in 
     			(SELECT b.isbn from Book b 
                 	where b.title = 'Good Omens')
    );

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
select e.employeeID, e.name from Employee e
join Contract c on c.employeeID = e.employeeID
where c.address like '%Booktown';


-- LIKE (string matching)
-- Compute the title of every book beginning with "The".
SELECT '<query 6>';
SELECT * 
    FROM Book
    WHERE title LIKE 'The%';