SELECT '<query 1>';
SELECT '<query 2>';
SELECT '<query 3>';

-- 
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

SELECT '<query 5>';
SELECT '<query 6>';