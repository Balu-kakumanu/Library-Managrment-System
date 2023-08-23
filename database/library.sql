
-- Database: library
--

-- Table structure for table admin
CREATE TABLE admin (
id INTEGER NOT NULL,
FullName VARCHAR(100) DEFAULT NULL,
AdminEmail VARCHAR(120) DEFAULT NULL,
UserName VARCHAR(100) NOT NULL,
Password VARCHAR(100) NOT NULL,
updationDate DATE NOT NULL
);

--

-- Dumping data for table admin
INSERT INTO admin (id, FullName, AdminEmail, UserName, Password, updationDate) VALUES
(101, 'Tom Cruze', 'tomcruze@yahoo.com', 'admin', 'admin', '2021-08-05'),
(100, 'Admin', 'admin@gmail.com', 'admin', 'admin', '2023-08-05');;

--

-- Table structure for table tblauthors
CREATE TABLE tblauthors (
id INTEGER NOT NULL,
AuthorName VARCHAR(159) DEFAULT NULL,
creationDate DATE DEFAULT NULL,
UpdationDate DATE DEFAULT NULL
);

--

-- Dumping data for table tblauthors
INSERT INTO tblauthors (id, AuthorName, creationDate, UpdationDate) VALUES
(1, 'Anuj kumar', '2021-08-05', '2021-08-05'),
(2, 'Chetan Bhagatt', '2021-08-05', '2021-08-05'),
(3, 'Anita Desai', '2021-08-05', NULL),
(4, 'HC Verma', '2021-08-05', NULL),
(5, 'R.D. Sharma ', '2021-08-05', NULL),
(9, 'fwdfrwer', '2021-08-05', NULL);

--

-- Table structure for table tblbooks
CREATE TABLE tblbooks (
id INTEGER NOT NULL,
BookName VARCHAR(255) DEFAULT NULL,
CatId INTEGER DEFAULT NULL,
AuthorId INTEGER DEFAULT NULL,
ISBNNumber INTEGER DEFAULT NULL,
BookPrice INTEGER DEFAULT NULL,
RegDate DATE DEFAULT NULL,
UpdationDate DATE DEFAULT NULL
);

--

-- Dumping data for table tblbooks
INSERT INTO tblbooks (id, BookName, CatId, AuthorId, ISBNNumber, BookPrice, RegDate, UpdationDate) VALUES
(1, 'PHP And MySql programming', 5, 1, 222333, 20, '2021-08-05', '2021-08-06'),
(3, 'physics', 6, 4, 1111, 15, '2021-08-05', '2021-08-07');

--

-- Table structure for table tblcategory
CREATE TABLE tblcategory (
id INTEGER NOT NULL,
CategoryName VARCHAR(150) DEFAULT NULL,
Status INTEGER DEFAULT NULL,
CreationDate DATE DEFAULT NULL,
UpdationDate DATE DEFAULT NULL
);

--
-- Dumping data for table tblcategory
INSERT INTO tblcategory (id, CategoryName, Status, CreationDate, UpdationDate) VALUES
(4, 'Romantic', 1, '2021-08-05', '2021-08-06'),
(5, 'Technology', 1, '2021-08-05', '2021-08-06'),
(6, 'Science', 1, '2021-08-05', '2021-08-07'),
(7, 'Management', 0, '2021-08-05', '2021-08-08');

-- Table structure for table tblissuedbookdetails
CREATE TABLE tblissuedbookdetails (
id INT NOT NULL,
BookId INT DEFAULT NULL,
StudentID VARCHAR(150) DEFAULT NULL,
IssuesDate DATE NULL,
ReturnDate DATE NULL,
RetrunStatus INT DEFAULT NULL,
fine INT DEFAULT NULL,
PRIMARY KEY (id)
);

-- Dumping data for table tblissuedbookdetails

INSERT INTO tblissuedbookdetails (id, BookId, StudentID, IssuesDate, ReturnDate, RetrunStatus, fine) VALUES
(1, 1, 'SID002', '2021-08-05', '2021-08-06', 1, 0),
(2, 1, 'SID002', '2021-08-05', '2021-08-07', 1, 5),
(3, 3, 'SID002', '2021-08-07', NULL, 0, NULL),
(4, 3, 'SID002', '2021-08-07', '2021-08-05', 1, 2),
(5, 1, 'SID009', '2021-08-08', NULL, 0, NULL),
(6, 3, 'SID011', '2021-08-08', NULL, 0, NULL);

-- Table structure for table tblstudents

CREATE TABLE tblstudents (
id INT NOT NULL,
StudentId VARCHAR(100) DEFAULT NULL,
FullName VARCHAR(120) DEFAULT NULL,
EmailId VARCHAR(120) DEFAULT NULL,
MobileNumber CHAR(11) DEFAULT NULL,
Password VARCHAR(120) DEFAULT NULL,
Status INT DEFAULT NULL,
RegDate DATE NULL,
UpdationDate DATE NULL,
PRIMARY KEY (id)
);

-- Dumping data for table tblstudents
INSERT INTO tblstudents (id, StudentId, FullName, EmailId, MobileNumber, Password, Status, RegDate, UpdationDate) VALUES
(1, 'SID002', 'Andrew Braza', 'andrew1@gmail.com', '9865472555', 'a111', 1, '2021-08-05', '2021-08-05'),
(4, 'SID005', 'John Roberts', 'john@yahoo.com', '8569710025', 'a111', 0, '2021-08-05', '2021-08-05'),
(9, 'SID010', 'Rey Tejada', 'rey@gmail.com', '8585856224','a111', 1, '2021-08-05', '2021-08-05'),
(10,'SID011', 'Clide Louie', 'CLIDE@gmail.com', '4672423754', 'a111', 1, '2021-08-05', '2021-08-05'),
(11,'SID012', 'Clive Dela Cruz', 'clive21@yahoo.com', '0945208280', 'a111', 1, '2021-08-05', NULL);


-- Dumping data for table tblstudents
INSERT INTO tblstudents (StudentId, FullName, EmailId, MobileNumber, Password, Status, RegDate, UpdationDate) VALUES
('SID002', 'Andrew Braza', 'andrew1@gmail.com', '9865472555', 'a111', 1, '2021-08-05', '2021-08-05'),
('SID005', 'John Roberts', 'john@yahoo.com', '8569710025', 'a111', 0, '2021-08-05', '2021-08-05'),
('SID010', 'Rey Tejada', 'rey@gmail.com', '8585856224', 'a111', 1, '2021-08-05', '2021-08-05'),
('SID011', 'Clide Louie', 'CLIDE@gmail.com', '4672423754', 'a111', 1, '2021-08-05', '2021-08-05'),
('SID012', 'Clive Dela Cruz', 'clive21@yahoo.com', '0945208280', 'a111', 1, '2021-08-05', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table admin
--
ALTER TABLE admin
  ADD PRIMARY KEY (id);

--
-- Indexes for table tblauthors
--
ALTER TABLE tblauthors
  ADD PRIMARY KEY (id);

--
-- Indexes for table tblbooks
--
ALTER TABLE tblbooks
  ADD PRIMARY KEY (id);

--
-- Indexes for table tblcategory
--
ALTER TABLE tblcategory
  ADD PRIMARY KEY (id);

--
-- Indexes for table tblissuedbookdetails
--
ALTER TABLE tblissuedbookdetails
  ADD PRIMARY KEY (id);



-- Indexes for table tblstudents
ALTER TABLE tblstudents
ADD PRIMARY KEY (id);

ALTER TABLE tblstudents
ADD CONSTRAINT sid_unique UNIQUE (StudentId);
