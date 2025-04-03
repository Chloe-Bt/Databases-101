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
    address     INTEGER     NOT NULL,
    salaryHOUR  INTEGER     CHECK (salaryHOUR >= 0)
                            NOT NULL,
    workHOURS   INTEGER     CHECK (salaryHOUR >= 0)
                            NOT NULL,
    function    TEXT        CHECK (function IN ('manager', 'shop assistant') OR function IS NULL),
    FOREIGN KEY (employeeID)REFERENCES Employee(employeeID),
    FOREIGN KEY (address)   REFERENCES Employee(address),
    PRIMARY KEY (employeeID, address)
);

DROP TABLE IF EXISTS Stocks;
CREATE TABLE Stocks(
    address     INTEGER,
    isbn        CHAR(13),
    stock       INTEGER     CHECK (stock >= 0)
                            NOT NULL,
    FOREIGN KEY (address)   REFERENCES Bookshop(address),
    FOREIGN KEY (isbn)      REFERENCES Book(isbn),
    PRIMARY KEY (address, isbn)
);

-- self-join example
DROP TABLE IF EXISTS AuthorFamily;
CREATE TABLE AuthorFamily(
    authorID    INTEGER     NOT NULL,
    name        TEXT        NOT NULL,
    role        TEXT        CHECK (role IN ('partner', 'parent', 'child') OR role IS NULL),
    FOREIGN KEY (authorID)  REFERENCES Author(authorID)
                            ON DELETE CASCADE,
    PRIMARY KEY (authorID, name)
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
-- The select statement was used for a more natural way of adding an author then just their ID.
-- But in essence it is just the authorID being used.
-- The seperate BookAuthor table was used for allowing multipel authors for the same book. 
INSERT INTO BookAuthor (isbn, authorID) VALUES 
    ('9780544003415', (SELECT authorID FROM Author WHERE name='John Ronald Reuel Tolkien')),
    ('9780747532743', (SELECT authorID FROM Author WHERE name='Joanne Rowling Rowling')),
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
    ('9780060256654', (SELECT authorID FROM Author WHERE name='Clive Staples Lewis')),
    ('9780439023528', (SELECT authorID FROM Author WHERE name='Suzanne Collins')),
    ('9780441172719', (SELECT authorID FROM Author WHERE name='Patrick Rothfuss')),
    ('9780765311788', (SELECT authorID FROM Author WHERE name='Brandon Sanderson')),
    ('9780007117116', (SELECT authorID FROM Author WHERE name='John Ronald Reuel Tolkien')),
    ('9780451526341', (SELECT authorID FROM Author WHERE name='George Orwell')),
    ('9780060935467', (SELECT authorID FROM Author WHERE name='Harper Lee')),
    ('9780199535569', (SELECT authorID FROM Author WHERE name='Leo Tolstoy')),
    ('9780140449136', (SELECT authorID FROM Author WHERE name='Fyodor Dostoevsky')),
    ('9780451530577', (SELECT authorID FROM Author WHERE name='Arthur Conan Doyle')),
    ('9780061120084', (SELECT authorID FROM Author WHERE name='Stephen King')),
    ('9780451205766', (SELECT authorID FROM Author WHERE name='Stephen King')),
    ('9780141439600', (SELECT authorID FROM Author WHERE name='Robert Louis Stevenson')),
    ('9780553382563', (SELECT authorID FROM Author WHERE name='Howard Phillips Lovecraft'));

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
    ('The Reading Nook', '123 Fiction Blvd, Booktown', 'franchise', 'Sophia Brown'),
    ('Novel Ideas', '456 Page St, Storyville', 'chain', 'Charlie Scott'),
    ('Page Turner Books', '789 Literary Ln, Biblioville', 'franchise', 'Ella Thomas'),
    ('Book Haven', '101 Bookworm Ave, Readsburgh', 'chain', 'Isabella Parker'),
    ('The Book Hive', '202 Reader Rd, Novelton', 'franchise', 'Jacob Nelson');

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
INSERT INTO Contract (employeeID, address, salaryHOUR, workHOURS, function) VALUES
    (1, '123 Fiction Blvd, Booktown', 15, 40, 'shop assistant'),
    (2, '123 Fiction Blvd, Booktown', 14, 35, 'shop assistant'),
    (3, '123 Fiction Blvd, Booktown', 16, 40, 'manager'),
    (4, '123 Fiction Blvd, Booktown', 18, 30, 'shop assistant'),
    (5, '123 Fiction Blvd, Booktown', 17, 25, 'shop assistant'),
    (6, '456 Page St, Storyville', 20, 40, 'shop assistant'),
    (7, '456 Page St, Storyville', 22, 38, 'shop assistant'),
    (8, '456 Page St, Storyville', 19, 40, 'manager'),
    (9, '456 Page St, Storyville', 21, 35, 'shop assistant'),
    (10, '456 Page St, Storyville', 23, 30, 'shop assistant'),
    (11, '789 Literary Ln, Biblioville', 17, 40, 'manager'),
    (12, '789 Literary Ln, Biblioville', 15, 35, 'shop assistant'),
    (13, '789 Literary Ln, Biblioville', 16, 40, 'manager'),
    (14, '789 Literary Ln, Biblioville', 18, 30, 'shop assistant'),
    (15, '789 Literary Ln, Biblioville', 19, 25, 'shop assistant'),
    (16, '101 Bookworm Ave, Readsburgh', 14, 40, 'shop assistant'),
    (17, '101 Bookworm Ave, Readsburgh', 20, 40, 'shop assistant'),
    (18, '101 Bookworm Ave, Readsburgh', 21, 38, 'shop assistant'),
    (19, '101 Bookworm Ave, Readsburgh', 22, 40, 'shop assistant'),
    (20, '101 Bookworm Ave, Readsburgh', 23, 35, 'shop assistant'),
    (21, '202 Reader Rd, Novelton', 18, 40, 'shop assistant'),
    (22, '202 Reader Rd, Novelton', 17, 35, 'shop assistant'),
    (23, '202 Reader Rd, Novelton', 19, 40, 'shop assistant'),
    (24, '202 Reader Rd, Novelton', 20, 30, 'manager'),
    (25, '202 Reader Rd, Novelton', 22, 38, 'shop assistant');    

-- Insert Stock Data for Bookshops and Books
INSERT INTO Stocks (address, isbn, stock) VALUES
    ('123 Fiction Blvd, Booktown', '9780544003415', 15),
    ('123 Fiction Blvd, Booktown', '9780747532743', 10),
    ('123 Fiction Blvd, Booktown', '9780451524935', 5),
    ('123 Fiction Blvd, Booktown', '9780553293357', 8),
    ('123 Fiction Blvd, Booktown', '9780547572290', 12),
    ('456 Page St, Storyville', '9780345339683', 20),
    ('456 Page St, Storyville', '9780743273565', 9),
    ('456 Page St, Storyville', '9780451532084', 7),
    ('456 Page St, Storyville', '9781509827731', 6),
    ('456 Page St, Storyville', '9780380977277', 11),
    ('789 Literary Ln, Biblioville', '9780060853983', 18),
    ('789 Literary Ln, Biblioville', '9780060256654', 13),
    ('789 Literary Ln, Biblioville', '9780439023528', 25),
    ('789 Literary Ln, Biblioville', '9780441172719', 17),
    ('789 Literary Ln, Biblioville', '9780765311788', 30),
    ('101 Bookworm Ave, Readsburgh', '9780007117116', 22),
    ('101 Bookworm Ave, Readsburgh', '9780451526341', 8),
    ('101 Bookworm Ave, Readsburgh', '9780060935467', 5),
    ('101 Bookworm Ave, Readsburgh', '9780199535569', 10),
    ('101 Bookworm Ave, Readsburgh', '9780140449136', 6),
    ('202 Reader Rd, Novelton', '9780451530577', 14),
    ('202 Reader Rd, Novelton', '9780061120084', 16),
    ('202 Reader Rd, Novelton', '9780451205766', 9),
    ('202 Reader Rd, Novelton', '9780141439600', 18),
    ('202 Reader Rd, Novelton', '9780553382563', 13);

INSERT INTO AuthorFamily (authorID, name, role) VALUES
    ((SELECT authorID FROM Author WHERE name='Frank Herbert'), 'Brian Patrick Herbert', 'child'),
    ((SELECT authorID FROM Author WHERE name='Joanne Rowling Rowling'), 'Neil Murray', 'partner'),
    ((SELECT authorID FROM Author WHERE name='Howard Phillips Lovecraft'), 'Sonia Haft Greene Lovecraft Davis', 'partner'),
    ((SELECT authorID FROM Author WHERE name='Frank Herbert'), 'Theresa Diane Shackelford', 'partner'),
    ((SELECT authorID FROM Author WHERE name='George Orwell'), 'Richard Blair', 'child');