
-- Database: library
--
create database library;
use library;

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
(001, 'Admistrator', 'admin@gmail.com', 'admin', 'admin', '2023-06-05'),
(308, 'Balu Kakumanu', 'rkakumanu09@gmail.com', 'Balu', 'Balu', '2023-06-05'),
(309, 'Srikanth Bingi', 'bingisrikanth@gmail.com', 'Srikanth', 'Srikanth', '2023-06-05');


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
(1, 'Horawitz Ellis', '2023-06-05', '2023-06-05'),
(2, 'Jain R.K', '2023-06-05', '2023-06-05'),
(3, 'Abraham Silberscgatz', '2023-06-05', '2023-06-05'),
(4, 'Herbert Schildt', '2023-06-05', '2023-06-05');

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
(1, 'Fundementals of Computer Algorithms', 1, 1, 222333, 40, '2023-06-05', '2023-06-05'),
(2, 'Fundementals of Data Structures in C', 2, 1, 222334, 20, '2023-06-05', '2023-06-05'),
(3, 'Advanced Engineering Mathematics', 4, 2, 222335, 30, '2023-06-05', '2023-06-05'),
(4, 'DataBase System Concepts', 3, 3, 222336, 50, '2023-06-05', '2023-06-05'),
(5, 'Operating System Concepts', 3, 3, 222337, 45, '2023-06-05', '2023-06-05'),
(6, 'JAVA : The Complete Reference', 2, 4, 222338, 20, '2023-06-05', '2023-06-05');


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
(1, 'Algorithms', 1, '2023-06-05', '2023-06-05'),
(2, 'Programming', 1, '2023-06-05', '2023-06-05'),
(3, 'Concepts of Programming', 1, '2023-06-05', '2023-06-05'),
(4, 'Mathematics', 1, '2023-06-05', '2023-06-05');

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
(1, 1, 'SID001', '2023-06-05', '2023-08-05', 1, 0),
(2, 1, 'SID002', '2023-06-05', '2023-08-05', 1, 5),
(3, 3, 'SID003', '2023-06-05', NULL, 0, NULL),
(4, 3, 'SID004', '2023-06-05', '2023-08-05', 1, 2),
(5, 1, 'SID005', '2023-06-05', NULL, 0, NULL);

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
(1, 'SID001', 'Ram', 'ram@gmail.com', '9865472555', 'Ram', 1, '2021-08-05', '2021-08-05'),
(2, 'SID002', 'Rohith', 'rohith@gmail.com', '8569710025', 'Rohith', 1, '2021-08-05', '2021-08-05'),
(3, 'SID003', 'Raghav', 'raghav@gmail.com', '8585856224','Raghav', 1, '2021-08-05', '2021-08-05'),
(4,'SID004', 'Aditya', 'Aditya@gmail.com', '9672423754', 'Aditya', 1, '2021-08-05', '2021-08-05'),
(5,'SID005', 'Anirudh', 'Anirudh@gmail.com', '9452082801', 'Anirudh', 1, '2021-08-05', NULL);

/*
-- Dumping data for table tblstudents
INSERT INTO tblstudents (StudentId, FullName, EmailId, MobileNumber, Password, Status, RegDate, UpdationDate) VALUES
('SID001', 'Andrew Braza', 'andrew1@gmail.com', '9865472555', 'a111', 1, '2021-08-05', '2021-08-05'),
('SID002', 'John Roberts', 'john@yahoo.com', '8569710025', 'a111', 0, '2021-08-05', '2021-08-05'),
('SID003', 'Rey Tejada', 'rey@gmail.com', '8585856224', 'a111', 1, '2021-08-05', '2021-08-05'),
('SID004', 'Clide Louie', 'CLIDE@gmail.com', '4672423754', 'a111', 1, '2021-08-05', '2021-08-05'),
('SID005', 'Clive Dela Cruz', 'clive21@yahoo.com', '0945208280', 'a111', 1, '2021-08-05', NULL);
*/
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
