-- Table creation
DROP TABLE IF EXISTS Book;
CREATE TABLE Book (
    isbn CHAR(13) PRIMARY KEY,
    title TEXT NOT NULL,
    language TEXT NOT NULL,
    publisher TEXT NOT NULL
);

DROP TABLE IF EXISTS Author;
CREATE TABLE Author (
    author_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

DROP TABLE IF EXISTS Book_Author;
CREATE TABLE Book_Author (
    isbn CHAR(13),
    author_id INTEGER,
    PRIMARY KEY (isbn, author_id),
    FOREIGN KEY (isbn) REFERENCES Book(isbn),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

DROP TABLE IF EXISTS Genre;
CREATE TABLE Genre (
    genre_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

DROP TABLE IF EXISTS Book_Genre;
CREATE TABLE Book_Genre (
    isbn CHAR(13),
    genre_id INTEGER,
    PRIMARY KEY (isbn, genre_id),
    FOREIGN KEY (isbn) REFERENCES Book(isbn),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);



-- Table fill
INSERT INTO Book (isbn, title, language, publisher) VALUES
('9780439064873', 'Harry Potter and the Chamber of Secrets', 'English', 'Bloomsbury'),
('9780743273565', 'Good Omens', 'English', 'Gollancz'),
('9780553382563', 'A Game of Thrones', 'English', 'Bantam Books'),
('9780316204279', 'Leviathan Wakes', 'English', 'Orbit');



INSERT INTO Author (name) VALUES
('J.K. Rowling'),
('Neil Gaiman'),
('Terry Pratchett'),
('George R.R. Martin'),
('James S.A. Corey'); -- James S.A. Corey is a pen name for two people, but stored as one



-- Harry Potter
INSERT INTO Book_Author (isbn, author_id) VALUES
('9780439064873', (SELECT author_id FROM Author WHERE name='J.K. Rowling'));

-- Good Omens (Multiple Authors)
INSERT INTO Book_Author (isbn, author_id) VALUES
('9780743273565', (SELECT author_id FROM Author WHERE name='Neil Gaiman')),
('9780743273565', (SELECT author_id FROM Author WHERE name='Terry Pratchett'));

-- A Game of Thrones
INSERT INTO Book_Author (isbn, author_id) VALUES
('9780553382563', (SELECT author_id FROM Author WHERE name='George R.R. Martin'));

-- Leviathan Wakes
INSERT INTO Book_Author (isbn, author_id) VALUES
('9780316204279', (SELECT author_id FROM Author WHERE name='James S.A. Corey'));



INSERT INTO Genre (name) VALUES
('Fantasy'),
('Adventure'),
('Comedy'),
('Science Fiction');



-- Harry Potter (Fantasy, Adventure)
INSERT INTO Book_Genre (isbn, genre_id) VALUES
('9780439064873', (SELECT genre_id FROM Genre WHERE name='Fantasy')),
('9780439064873', (SELECT genre_id FROM Genre WHERE name='Adventure'));

-- Good Omens (Fantasy, Comedy)
INSERT INTO Book_Genre (isbn, genre_id) VALUES
('9780743273565', (SELECT genre_id FROM Genre WHERE name='Fantasy')),
('9780743273565', (SELECT genre_id FROM Genre WHERE name='Comedy'));

-- A Game of Thrones (Fantasy)
INSERT INTO Book_Genre (isbn, genre_id) VALUES
('9780553382563', (SELECT genre_id FROM Genre WHERE name='Fantasy'));

-- Leviathan Wakes (Science Fiction)
INSERT INTO Book_Genre (isbn, genre_id) VALUES
('9780316204279', (SELECT genre_id FROM Genre WHERE name='Science Fiction'));




