SELECT b.title, GROUP_CONCAT(a.name, ', ') AS authors
FROM Book b
JOIN Book_Author ba ON b.isbn = ba.isbn
JOIN Author a ON ba.author_id = a.author_id
GROUP BY b.isbn;