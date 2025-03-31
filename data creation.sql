-- Create all tables
DROP TABLE IF EXISTS Book;
CREATE TABLE Book(
    isbn        CHAR(13),
    title       TEXT        NOT NULL,
    language    TEXT        NOT NULL,
    publisher   TEXT        NOT NULL,
    PRIMARY KEY (isbn)
);

DROP TABLE IF EXISTS Author;
CREATE TABLE Author(
    authorID    INTEGER     PRIMARY KEY
                            AUTOINCREMENT,
    name        TEXT        UNIQUE
                            NOT NULL
);

DROP TABLE IF EXISTS BookAuthor;
CREATE TABLE BookAuthor(
    isbn        CHAR(13),
    authorID    INTEGER,
    FOREIGN KEY (isbn)      REFERENCES Book(isbn),
    FOREIGN KEY (authorID)  REFERENCES Author(authorID),
    PRIMARY KEY (isbn, authorID)
);

DROP TABLE IF EXISTS Genre;
CREATE TABLE Genre(
    name        TEXT        PRIMARY KEY
                            NOT NULL
);

DROP TABLE IF EXISTS BookGenre;
CREATE TABLE BookGenre(
    isbn        CHAR(13),
    genreID     INTEGER,
    FOREIGN KEY (isbn)      REFERENCES Book(isbn),
    FOREIGN KEY (genreID)   REFERENCES Genre(genreID),
    PRIMARY KEY (isbn, genreID)
);

DROP TABLE IF EXISTS Bookshop;
CREATE TABLE Bookshop(
    address     TEXT        PRIMARY KEY
                            NOT NULL,
    name        TEXT        NOT NULL,
    shopTYPE    TEXT        CHECK (shopTYPE IN ('franchise', 'chain') OR shopTYPE IS NULL),
    manager     TEXT        NOT NULL
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee(
    employeeID  INTEGER     PRIMARY KEY
                            AUTOINCREMENT,
    name        TEXT        NOT NULL
);

DROP TABLE IF EXISTS Contract;
CREATE TABLE Contract(
    employeeID  INTEGER     NOT NULL,
    shopID      INTEGER     NOT NULL,
    salaryHOUR  INTEGER     CHECK (salaryHOUR >= 0)
                            NOT NULL,
    workHOURS   INTEGER     CHECK (salaryHOUR >= 0)
                            NOT NULL,
    function    TEXT        CHECK (function IN ('manager', 'shop assistant') OR function IS NULL),
    FOREIGN KEY (employeeID)REFERENCES Employee(employeeID),
    FOREIGN KEY (shopID)    REFERENCES Employee(shopID),
    PRIMARY KEY (employeeID, shopID)
);

DROP TABLE IF EXISTS Stock;
CREATE TABLE Stock(
    shopID      INTEGER,
    isbn        CHAR(13),
    stock       INTEGER     CHECK (stock >= 0)
                            NOT NULL,
    FOREIGN KEY (shopID)    REFERENCES Bookshop(shopID),
    FOREIGN KEY (isbn)      REFERENCES Book(isbn),
    PRIMARY KEY (shopID, isbn)
);

-- self-join example
DROP TABLE IF EXISTS AuthorFamily;
CREATE TABLE AuthorFamily(
    author      TEXT        NOT NULL,
    name        TEXT        NOT NULL,
    role        TEXT        CHECK (role IN ('partner', 'parent', 'child') OR role IS NULL),
    FOREIGN KEY (author)    REFERENCES Author(name)
                            ON DELETE CASCADE,
    PRIMARY KEY (author, name)
);



-- Fill tables with information
-- Filling the tables was done by politely asking chatgpt for a wide
-- variety of information for the specific tables we wrote above.
-- Insert Book
INSERT INTO Book (isbn, title, language, publisher) VALUES
    ('9780544003415', 'The Hobbit', 'English', 'Allen & Unwin'),
    ('9780747532743', 'Harry Potter and the Philosopher''s Stone', 'English', 'Bloomsbury'),
    ('9780451524935', '1984', 'English', 'Secker & Warburg'),
    ('9780553293357', 'Foundation', 'English', 'Gnome Press'),
    ('9780547572290', 'Dune', 'English', 'Chilton Books'),
    ('9780345339683', 'The Hitchhiker''s Guide to the Galaxy', 'English', 'Pan Books'),
    ('9780743273565', 'Fahrenheit 451', 'English', 'Ballantine Books'),
    ('9780451532084', 'Dracula', 'English', 'Archibald Constable and Company'),
    ('9781509827731', 'Frankenstein', 'English', 'Lackington, Hughes, Harding, Mavor & Jones'),
    ('9780380977277', 'American Gods', 'English', 'William Morrow'),
    ('9780060853983', 'Good Omens', 'English', 'Gollancz'),
    ('9780060256654', 'The Chronicles of Narnia', 'English', 'Geoffrey Bles'),
    ('9780439023528', 'The Hunger Games', 'English', 'Scholastic'),
    ('9780441172719', 'The Name of the Wind', 'English', 'DAW Books'),
    ('9780765311788', 'Mistborn', 'English', 'Tor Books'),
    ('9780007117116', 'The Lord of the Rings', 'English', 'Allen & Unwin'),
    ('9780451526341', 'Brave New World', 'English', 'Chatto & Windus'),
    ('9780060935467', 'To Kill a Mockingbird', 'English', 'J.B. Lippincott & Co.'),
    ('9780199535569', 'War and Peace', 'English', 'The Russian Messenger'),
    ('9780140449136', 'Crime and Punishment', 'English', 'The Russian Messenger'),
    ('9780451530577', 'The Adventures of Sherlock Holmes', 'English', 'George Newnes'),
    ('9780061120084', 'The Stand', 'English', 'Doubleday'),
    ('9780451205766', 'The Shining', 'English', 'Doubleday'),
    ('9780141439600', 'Strange Case of Dr Jekyll and Mr Hyde', 'English', 'Longmans, Green & Co.'),
    ('9780553382563', 'The Call of Cthulhu and Other Weird Stories', 'English', 'Arkham House');

-- Insert Author
INSERT INTO Author (name) VALUES
    ('John Ronald Reuel Tolkien'),
    ('Joanne Rowling Rowling'),
    ('George Orwell'),
    ('Isaac Asimov'),
    ('Philip Kindred Dick'),
    ('Stephen King'),
    ('Agatha Christie'),
    ('Arthur Conan Doyle'),
    ('Herbert George Wells'),
    ('Ray Bradbury'),
    ('Mary Shelley'),
    ('Frank Herbert'),
    ('Douglas Adams'),
    ('Bram Stoker'),
    ('Robert Louis Stevenson'),
    ('Howard Phillips Lovecraft'),
    ('Terry Pratchett'),
    ('Neil Gaiman'),
    ('Margaret Atwood'),
    ('Brandon Sanderson'),
    ('Patrick Rothfuss'),
    ('Clive Staples Lewis'),
    ('Suzanne Collins'),
    ('Harper Lee'),
    ('Leo Tolstoy'),
    ('Fyodor Dostoevsky'),
    ('Mark Twain');

-- Insert Genre
INSERT INTO Genre (name) VALUES
    ('Fantasy'),
    ('Science Fiction'),
    ('Dystopian'),
    ('Horror'),
    ('Mystery'),
    ('Detective'),
    ('Classic'),
    ('Thriller'),
    ('Adventure'),
    ('Steampunk');

-- Insert Book-Author Relationships
INSERT INTO BookAuthor (isbn, authorID) VALUES 
    ('9780544003415', (SELECT authorID FROM Author WHERE name='J.R.R. Tolkien')),
    ('9780747532743', (SELECT authorID FROM Author WHERE name='J.K. Rowling')),
    ('9780451524935', (SELECT authorID FROM Author WHERE name='George Orwell')),
    ('9780553293357', (SELECT authorID FROM Author WHERE name='Isaac Asimov')),
    ('9780547572290', (SELECT authorID FROM Author WHERE name='Frank Herbert')),
    ('9780345339683', (SELECT authorID FROM Author WHERE name='Douglas Adams')),
    ('9780743273565', (SELECT authorID FROM Author WHERE name='Ray Bradbury')),
    ('9780451532084', (SELECT authorID FROM Author WHERE name='Bram Stoker')),
    ('9781509827731', (SELECT authorID FROM Author WHERE name='Mary Shelley')),
    ('9780380977277', (SELECT authorID FROM Author WHERE name='Neil Gaiman')),
    ('9780060853983', (SELECT authorID FROM Author WHERE name='Terry Pratchett')),
    ('9780060853983', (SELECT authorID FROM Author WHERE name='Neil Gaiman')),
    ('9780060256654', (SELECT authorID FROM Author WHERE name='C.S. Lewis')),
    ('9780439023528', (SELECT authorID FROM Author WHERE name='Suzanne Collins')),
    ('9780441172719', (SELECT authorID FROM Author WHERE name='Patrick Rothfuss')),
    ('9780765311788', (SELECT authorID FROM Author WHERE name='Brandon Sanderson')),
    ('9780007117116', (SELECT authorID FROM Author WHERE name='J.R.R. Tolkien')),
    ('9780451526341', (SELECT authorID FROM Author WHERE name='George Orwell')),
    ('9780060935467', (SELECT authorID FROM Author WHERE name='Harper Lee')),
    ('9780199535569', (SELECT authorID FROM Author WHERE name='Leo Tolstoy')),
    ('9780140449136', (SELECT authorID FROM Author WHERE name='Fyodor Dostoevsky')),
    ('9780451530577', (SELECT authorID FROM Author WHERE name='Arthur Conan Doyle')),
    ('9780061120084', (SELECT authorID FROM Author WHERE name='Stephen King')),
    ('9780451205766', (SELECT authorID FROM Author WHERE name='Stephen King')),
    ('9780141439600', (SELECT authorID FROM Author WHERE name='Robert Louis Stevenson')),
    ('9780553382563', (SELECT authorID FROM Author WHERE name='H.P. Lovecraft'));

-- Insert Book-Genre Relationships
INSERT INTO BookGenre (isbn, genreID) VALUES 
    ('9780544003415', 'Fantasy'),
    ('9780747532743', 'Fantasy'),
    ('9780451524935', 'Dystopian'),
    ('9780553293357', 'Science Fiction'),
    ('9780547572290', 'Science Fiction'),
    ('9780345339683', 'Science Fiction'),
    ('9780743273565', 'Dystopian'),
    ('9780451532084', 'Horror'),
    ('9781509827731', 'Horror'),
    ('9780380977277', 'Fantasy'),
    ('9780060853983', 'Fantasy'),
    ('9780060853983', 'Science Fiction'),
    ('9780060256654', 'Fantasy'),
    ('9780439023528', 'Dystopian'),
    ('9780441172719', 'Fantasy'),
    ('9780765311788', 'Science Fiction'),
    ('9780007117116', 'Fantasy'),
    ('9780451526341', 'Dystopian'),
    ('9780060935467', 'Classic'),
    ('9780199535569', 'Classic'),
    ('9780140449136', 'Classic'),
    ('9780451530577', 'Detective'),
    ('9780061120084', 'Horror'),
    ('9780451205766', 'Horror'),
    ('9780141439600', 'Horror'),
    ('9780553382563', 'Horror');

-- Insert Bookshop
INSERT INTO Bookshop (name, address, shopTYPE, manager) VALUES 
    ('The Reading Nook', '123 Fiction Blvd, Booktown', 'franchise', 'Alice Johnson'),
    ('Novel Ideas', '456 Page St, Storyville', 'chain', 'Mark Roberts'),
    ('Page Turner Books', '789 Literary Ln, Biblioville', 'franchise', 'Rachel Green'),
    ('Book Haven', '101 Bookworm Ave, Readsburgh', 'chain', 'John Smith'),
    ('The Book Hive', '202 Reader Rd, Novelton', 'franchise', 'Emma White');

-- Insert Employee
INSERT INTO Employee (name) VALUES 
    ('Megan Clark'),
    ('Lucas Taylor'),
    ('Sophia Brown'),
    ('James Davis'),
    ('Lily Evans'),
    ('Ben Harris'),
    ('Olivia White'),
    ('Ella Thomas'),
    ('Jack Wilson'),
    ('David Lee'),
    ('Charlie Scott'),
    ('Ava Adams'),
    ('Isabella Parker'),
    ('Mason Harris'),
    ('Amelia Walker'),
    ('Henry Young'),
    ('Grace King'),
    ('Ethan Green'),
    ('Mila Carter'),
    ('Sebastian Allen'),
    ('Aiden Robinson'),
    ('Harper Lewis'),
    ('Madeline Hall'),
    ('Jacob Nelson'),
    ('Chloe Martinez');
    
-- Insert Contract Data for Each Employee
INSERT INTO Contract (employeeID, shopID, salaryHOUR, workHOURS) VALUES
    (1, 1, 15, 40),
    (2, 1, 14, 35),
    (3, 1, 16, 40),
    (4, 1, 18, 30),
    (5, 1, 17, 25),
    (6, 2, 20, 40),
    (7, 2, 22, 38),
    (8, 2, 19, 40),
    (9, 2, 21, 35),
    (10, 2, 23, 30),
    (11, 3, 17, 40),
    (12, 3, 15, 35),
    (13, 3, 16, 40),
    (14, 3, 18, 30),
    (15, 3, 19, 25),
    (16, 4, 14, 40),
    (17, 4, 20, 40),
    (18, 4, 21, 38),
    (19, 4, 22, 40),
    (20, 4, 23, 35),
    (21, 5, 18, 40),
    (22, 5, 17, 35),
    (23, 5, 19, 40),
    (24, 5, 20, 30),
    (25, 5, 22, 38);

-- Insert Stock Data for Bookshops and Books
INSERT INTO Stock (shopID, isbn, stock) VALUES
    (1, '9780544003415', 15),
    (1, '9780747532743', 10),
    (1, '9780451524935', 5),
    (1, '9780553293357', 8),
    (1, '9780547572290', 12),
    (2, '9780345339683', 20),
    (2, '9780743273565', 9),
    (2, '9780451532084', 7),
    (2, '9781509827731', 6),
    (2, '9780380977277', 11),
    (3, '9780060853983', 18),
    (3, '9780060256654', 13),
    (3, '9780439023528', 25),
    (3, '9780441172719', 17),
    (3, '9780765311788', 30),
    (4, '9780007117116', 22),
    (4, '9780451526341', 8),
    (4, '9780060935467', 5),
    (4, '9780199535569', 10),
    (4, '9780140449136', 6),
    (5, '9780451530577', 14),
    (5, '9780061120084', 16),
    (5, '9780451205766', 9),
    (5, '9780141439600', 18),
    (5, '9780553382563', 13);

INSERT INTO AuthorFamily (author, name, role) VALUES
    ('', '', 'partner')
    ;