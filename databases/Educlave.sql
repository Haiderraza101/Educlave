-- CREATE DATABASE IF NOT EXISTS Educlave;
-- USE Educlave;

-- CREATE TABLE Users (
--     userid INT PRIMARY KEY AUTO_INCREMENT,
--     username VARCHAR(255) NOT NULL UNIQUE,
--     passwordhash VARCHAR(255) NOT NULL,
--     role ENUM('Student', 'Teacher') NOT NULL,
--     usercreatedate DATETIME DEFAULT CURRENT_TIMESTAMP
-- );


-- CREATE TABLE Students (
--     studentid INT PRIMARY KEY AUTO_INCREMENT,
--     userid INT,
--     rollnumber VARCHAR(20) NOT NULL UNIQUE,
--     firstname VARCHAR(255) NOT NULL,
--     lastname VARCHAR(255) NOT NULL,
--     dateofbirth DATE NOT NULL,
--     gender ENUM('Male', 'Female', 'Other', 'Prefer not to say'),
--     contactnumber VARCHAR(15) UNIQUE,
--     email VARCHAR(100) UNIQUE,
--     address TEXT NOT NULL,
--     guardianname VARCHAR(255),
--     guardiancontact VARCHAR(15),
--     guardianrelation VARCHAR(100),
--     enrollmentdate DATE NOT NULL,
--     currentsemester VARCHAR(50),
--     department VARCHAR(100),
--     program VARCHAR(100),
--     studentcreateddate DATETIME DEFAULT CURRENT_TIMESTAMP,
--     role ENUM('Student') DEFAULT 'Student',
--     age INT CHECK(age > 5 AND age < 80),
--     FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE
-- );


-- CREATE TABLE Teachers (
--     teacherid INT PRIMARY KEY AUTO_INCREMENT,
--     userid INT,
--     firstname VARCHAR(255) NOT NULL,
--     lastname VARCHAR(255) NOT NULL,
--     dateofbirth DATE,
--     gender ENUM('Male', 'Female', 'Other', 'Prefer not to say'),
--     contactnumber VARCHAR(15) UNIQUE,
--     email VARCHAR(100) UNIQUE,
--     address TEXT,
--     specialization VARCHAR(255) NOT NULL,
--     qualification TEXT NOT NULL,
--     previousexperience TEXT,
--     department VARCHAR(100) NOT NULL,
--     teachercreateddate DATETIME DEFAULT CURRENT_TIMESTAMP,
--     role ENUM('Teacher') DEFAULT 'Teacher',
--     age INT CHECK (age > 22 AND age < 80),
--     FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE
-- );



-- CREATE TABLE Courses (
--     courseid INT PRIMARY KEY AUTO_INCREMENT,
--     coursecode VARCHAR(20) NOT NULL UNIQUE,
--     coursename VARCHAR(100) NOT NULL,
--     description TEXT,
--     credithours INT NOT NULL,
--     teacherid INT NOT NULL,
--     createdat DATETIME DEFAULT CURRENT_TIMESTAMP,
--     maxcapacity INT DEFAULT 30,
--     isactive BOOLEAN DEFAULT TRUE,
--     FOREIGN KEY (teacherid) REFERENCES Teachers(teacherid)
-- );



-- CREATE TABLE Enrollments (
--     enrollmentid INT PRIMARY KEY AUTO_INCREMENT,
--     studentid INT NOT NULL,
--     courseid INT NOT NULL,
--     enrollmentdate DATETIME DEFAULT CURRENT_TIMESTAMP,
--     status ENUM('Active', 'Completed', 'Dropped') DEFAULT 'Active',
--     UNIQUE KEY (studentid, courseid),
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid)
-- );


-- CREATE TABLE Quizzes (
--     quizid INT PRIMARY KEY AUTO_INCREMENT,
--     courseid INT NOT NULL,
--     studentid INT NOT NULL,
--     totalmarks DECIMAL(5,2) NOT NULL DEFAULT 10.00,
--     obtainedmarks DECIMAL(5,2) NOT NULL,
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid),
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     UNIQUE KEY (courseid, studentid, quizid)
-- );


-- CREATE TABLE Assignments (
--     assignmentid INT PRIMARY KEY AUTO_INCREMENT,
--     courseid INT NOT NULL,
--     studentid INT NOT NULL,
--     totalmarks DECIMAL(5,2) NOT NULL DEFAULT 10.00,
--     obtainedmarks DECIMAL(5,2) NOT NULL,
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid),
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     UNIQUE KEY (courseid, studentid, assignmentid)
-- );



-- CREATE TABLE Midterms (
--     midtermid INT PRIMARY KEY AUTO_INCREMENT,
--     courseid INT NOT NULL,
--     studentid INT NOT NULL,
--     totalmarks DECIMAL(5,2) NOT NULL DEFAULT 30.00,
--     obtainedmarks DECIMAL(5,2) NOT NULL,
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid),
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     UNIQUE KEY (courseid, studentid)
-- );


-- CREATE TABLE Finals (
--     finalid INT PRIMARY KEY AUTO_INCREMENT,
--     courseid INT NOT NULL,
--     studentid INT NOT NULL,
--     totalmarks DECIMAL(5,2) NOT NULL DEFAULT 50.00,
--     obtainedmarks DECIMAL(5,2) NOT NULL,
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid),
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     UNIQUE KEY (courseid, studentid)
-- );


-- CREATE TABLE Grades (
--     gradeid INT PRIMARY KEY AUTO_INCREMENT,
--     studentid INT NOT NULL,
--     courseid INT NOT NULL,
--     quiztotal DECIMAL(5,2) DEFAULT 0,
--     quizobtained DECIMAL(5,2) DEFAULT 0,
--     assignmenttotal DECIMAL(5,2) DEFAULT 0,
--     assignmentobtained DECIMAL(5,2) DEFAULT 0,
--     midtermtotal DECIMAL(5,2) DEFAULT 30.00,
--     midtermobtained DECIMAL(5,2) DEFAULT 0,
--     finaltotal DECIMAL(5,2) DEFAULT 50.00,
--     finalobtained DECIMAL(5,2) DEFAULT 0,
--      totalgrandtotal DECIMAL(5,2) DEFAULT 100,
--     obtainedgrandtotal DECIMAL(5,2) GENERATED ALWAYS AS (
--         quizobtained + assignmentobtained + midtermobtained + finalobtained
--     ) STORED,
--     lettergrade VARCHAR(2),
--     UNIQUE KEY (studentid, courseid),
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid)
-- );


-- CREATE TABLE Transcripts (
--     transcriptid INT PRIMARY KEY AUTO_INCREMENT,
--     studentid INT NOT NULL,
--     courseid INT NOT NULL,
--     coursecode VARCHAR(20) NOT NULL,
--     coursename VARCHAR(100) NOT NULL,
--     credithours INT NOT NULL,
--     semester VARCHAR(20) NOT NULL,
--     year INT NOT NULL,
--     lettergrade VARCHAR(2) NOT NULL,
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid)
-- );


-- CREATE TABLE Attendance (
--     attendanceid INT PRIMARY KEY AUTO_INCREMENT,
--     courseid INT NOT NULL,
--     studentid INT NOT NULL,
--     date DATE NOT NULL,
--     status ENUM('Present', 'Absent', 'Late') NOT NULL,
--     FOREIGN KEY (courseid) REFERENCES Courses(courseid),
--     FOREIGN KEY (studentid) REFERENCES Students(studentid),
--     UNIQUE KEY (courseid, studentid, date)
-- );


-- INSERT INTO Users (username, passwordhash, role) VALUES
-- ('john_doe', 'hashed123', 'Student'),
-- ('jane_smith', 'hashed456', 'Student'),
-- ('mike_jones', 'hashed789', 'Student'),
-- ('sarah_wilson', 'hashed101', 'Student'),
-- ('alex_brown', 'hashed112', 'Student'),
-- ('dr_smith', 'hashed131', 'Teacher'),
-- ('prof_johnson', 'hashed415', 'Teacher'),
-- ('dr_williams', 'hashed161', 'Teacher'),
-- ('prof_miller', 'hashed718', 'Teacher'),
-- ('dr_davis', 'hashed191', 'Teacher');



-- INSERT INTO Students (userid, rollnumber, firstname, lastname, dateofbirth, gender, contactnumber, email, address, guardianname, guardiancontact, guardianrelation, enrollmentdate, currentsemester, department, program, age) VALUES
-- (1, 'STU001', 'John', 'Doe', '2000-05-15', 'Male', '1234567890', 'john@example.com', '123 Main St, City', 'James Doe', '0987654321', 'Father', '2022-09-01', 'Fall 2023', 'Computer Science', 'BS CS', 22),
-- (2, 'STU002', 'Jane', 'Smith', '2001-03-22', 'Female', '2345678901', 'jane@example.com', '456 Oak Ave, Town', 'Mary Smith', '9876543210', 'Mother', '2022-09-01', 'Fall 2023', 'Mathematics', 'BS Math', 21),
-- (3, 'STU003', 'Mike', 'Jones', '1999-11-30', 'Male', '3456789012', 'mike@example.com', '789 Pine Rd, Village', 'Robert Jones', '8765432109', 'Father', '2021-09-01', 'Fall 2023', 'Physics', 'BS Physics', 23),
-- (4, 'STU004', 'Sarah', 'Wilson', '2000-07-18', 'Female', '4567890123', 'sarah@example.com', '321 Elm St, City', 'David Wilson', '7654321098', 'Father', '2022-09-01', 'Fall 2023', 'Biology', 'BS Biology', 22),
-- (5, 'STU005', 'Alex', 'Brown', '2001-01-25', 'Other', '5678901234', 'alex@example.com', '654 Maple Dr, Town', 'Lisa Brown', '6543210987', 'Mother', '2023-01-15', 'Fall 2023', 'Chemistry', 'BS Chemistry', 21);



-- INSERT INTO Teachers (userid, firstname, lastname, dateofbirth, gender, contactnumber, email, address, specialization, qualification, previousexperience, department, age) VALUES
-- (6, 'Robert', 'Smith', '1975-04-10', 'Male', '6789012345', 'r.smith@example.com', '111 University Ave', 'Database Systems', 'PhD in Computer Science', '10 years at Tech University', 'Computer Science', 48),
-- (7, 'Emily', 'Johnson', '1980-08-15', 'Female', '7890123456', 'e.johnson@example.com', '222 College St', 'Calculus', 'PhD in Mathematics', '8 years at State College', 'Mathematics', 43),
-- (8, 'David', 'Williams', '1978-12-20', 'Male', '8901234567', 'd.williams@example.com', '333 Campus Rd', 'Quantum Physics', 'PhD in Physics', '12 years at Science Institute', 'Physics', 45),
-- (9, 'Jennifer', 'Miller', '1982-06-05', 'Female', '9012345678', 'j.miller@example.com', '444 School Lane', 'Molecular Biology', 'PhD in Biology', '7 years at Bio Research Center', 'Biology', 41),
-- (10, 'Michael', 'Davis', '1970-03-30', 'Male', '0123456789', 'm.davis@example.com', '555 Academy Blvd', 'Organic Chemistry', 'PhD in Chemistry', '15 years at Chem University', 'Chemistry', 53);



-- INSERT INTO Courses (coursecode, coursename, description, credithours, teacherid, maxcapacity) VALUES
-- ('CS101', 'Introduction to Programming', 'Basic programming concepts', 3, 1, 30),
-- ('MATH201', 'Calculus I', 'Differential calculus', 4, 2, 25),
-- ('PHYS301', 'Modern Physics', 'Introduction to modern physics', 3, 3, 20),
-- ('BIO401', 'Genetics', 'Principles of genetics', 4, 4, 25),
-- ('CHEM501', 'Organic Chemistry', 'Structure and reactions', 4, 5, 20);


-- INSERT INTO Quizzes (courseid, studentid, totalmarks, obtainedmarks) VALUES
-- (1, 1, 10, 8.5),
-- (1, 2, 10, 7.0),
-- (1, 5, 10, 9.0),
-- (2, 1, 10, 8.0),
-- (2, 3, 10, 6.5),
-- (3, 2, 10, 7.5),
-- (3, 4, 10, 8.0),
-- (4, 3, 10, 9.5),
-- (5, 4, 10, 7.0),
-- (5, 5, 10, 8.5);



-- INSERT INTO Assignments (courseid, studentid, totalmarks, obtainedmarks) VALUES
-- (1, 1, 10, 9.0),
-- (1, 2, 10, 8.5),
-- (1, 5, 10, 9.5),
-- (2, 1, 10, 7.5),
-- (2, 3, 10, 8.0),
-- (3, 2, 10, 8.0),
-- (3, 4, 10, 7.5),
-- (4, 3, 10, 9.0),
-- (5, 4, 10, 8.5),
-- (5, 5, 10, 9.0);



-- INSERT INTO Midterms (courseid, studentid, totalmarks, obtainedmarks) VALUES
-- (1, 1, 30, 25.5),
-- (1, 2, 30, 22.0),
-- (1, 5, 30, 27.0),
-- (2, 1, 30, 24.0),
-- (2, 3, 30, 19.5),
-- (3, 2, 30, 22.5),
-- (3, 4, 30, 24.0),
-- (4, 3, 30, 28.5),
-- (5, 4, 30, 21.0),
-- (5, 5, 30, 25.5);



-- INSERT INTO Midterms (courseid, studentid, totalmarks, obtainedmarks) VALUES
-- (1, 1, 30, 25.5),
-- (1, 2, 30, 22.0),
-- (1, 5, 30, 27.0),
-- (2, 1, 30, 24.0),
-- (2, 3, 30, 19.5),
-- (3, 2, 30, 22.5),
-- (3, 4, 30, 24.0),
-- (4, 3, 30, 28.5),
-- (5, 4, 30, 21.0),
-- (5, 5, 30, 25.5);



-- INSERT INTO Finals (courseid, studentid, totalmarks, obtainedmarks) VALUES
-- (1, 1, 50, 42.5),
-- (1, 2, 50, 38.0),
-- (1, 5, 50, 45.0),
-- (2, 1, 50, 40.0),
-- (2, 3, 50, 32.5),
-- (3, 2, 50, 37.5),
-- (3, 4, 50, 40.0),
-- (4, 3, 50, 47.5),
-- (5, 4, 50, 35.0),
-- (5, 5, 50, 42.5);


-- INSERT INTO Transcripts (studentid, courseid, coursecode, coursename, credithours, semester, year, lettergrade) VALUES
-- (1, 1, 'CS101', 'Introduction to Programming', 3, 'Fall', 2023, 'A'),
-- (1, 2, 'MATH201', 'Calculus I', 4, 'Fall', 2023, 'B+'),
-- (2, 1, 'CS101', 'Introduction to Programming', 3, 'Fall', 2023, 'B'),
-- (2, 3, 'PHYS301', 'Modern Physics', 3, 'Fall', 2023, 'B'),
-- (3, 2, 'MATH201', 'Calculus I', 4, 'Fall', 2023, 'C+'),
-- (3, 4, 'BIO401', 'Genetics', 4, 'Fall', 2023, 'A+'),
-- (4, 3, 'PHYS301', 'Modern Physics', 3, 'Fall', 2023, 'B+'),
-- (4, 5, 'CHEM501', 'Organic Chemistry', 4, 'Fall', 2023, 'B-'),
-- (5, 1, 'CS101', 'Introduction to Programming', 3, 'Fall', 2023, 'A'),
-- (5, 5, 'CHEM501', 'Organic Chemistry', 4, 'Fall', 2023, 'A');


-- INSERT INTO Grades (studentid, courseid, quiztotal, quizobtained, assignmenttotal, assignmentobtained, midtermtotal, midtermobtained, finaltotal, finalobtained, lettergrade) VALUES
-- (1, 1, 10, 8.5, 10, 9.0, 30, 25.5, 50, 42.5, 'A'),
-- (1, 2, 10, 8.0, 10, 7.5, 30, 24.0, 50, 40.0, 'B+'),
-- (2, 1, 10, 7.0, 10, 8.5, 30, 22.0, 50, 38.0, 'B'),
-- (2, 3, 10, 7.5, 10, 8.0, 30, 22.5, 50, 37.5, 'B'),
-- (3, 2, 10, 6.5, 10, 8.0, 30, 19.5, 50, 32.5, 'C+'),
-- (3, 4, 10, 9.5, 10, 9.0, 30, 28.5, 50, 47.5, 'A+'),
-- (4, 3, 10, 8.0, 10, 7.5, 30, 24.0, 50, 40.0, 'B+'),
-- (4, 5, 10, 7.0, 10, 8.5, 30, 21.0, 50, 35.0, 'B-'),
-- (5, 1, 10, 9.0, 10, 9.5, 30, 27.0, 50, 45.0, 'A'),
-- (5, 5, 10, 8.5, 10, 9.0, 30, 25.5, 50, 42.5, 'A');

-- INSERT INTO Attendance (courseid, studentid, date, status) VALUES
-- (1, 1, '2023-09-05', 'Present'),
-- (1, 1, '2023-09-12', 'Present'),
-- (1, 1, '2023-09-19', 'Late'),
-- (1, 2, '2023-09-05', 'Present'),
-- (1, 2, '2023-09-12', 'Absent'),
-- (1, 5, '2023-09-05', 'Present'),
-- (2, 1, '2023-09-06', 'Present'),
-- (2, 3, '2023-09-06', 'Present'),
-- (3, 2, '2023-09-07', 'Present'),
-- (3, 4, '2023-09-07', 'Late');



-- ALTER TABLE Courses
-- ADD COLUMN studentid INT,
-- ADD CONSTRAINT fk_courses_student
-- FOREIGN KEY (studentid) REFERENCES Students(studentid);

-- INSERT INTO Courses (coursecode, coursename, description, credithours, teacherid, maxcapacity, studentid) VALUES
-- ('CS202', 'Data Structures', 'Study of data structures', 3, 1, 30, 6),
-- ('CS203', 'Web Development', 'Frontend and backend web development', 3, 1, 30, 6);

-- SELECT CONSTRAINT_NAME 
-- FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
-- WHERE TABLE_NAME = 'assignments' AND TABLE_SCHEMA = 'Educlave' AND REFERENCED_TABLE_NAME IS NOT NULL;

-- ALTER TABLE Quizzes DROP FOREIGN KEY quizzes_ibfk_1;
-- ALTER TABLE Quizzes DROP FOREIGN KEY quizzes_ibfk_2;


-- ALTER TABLE Quizzes DROP INDEX courseid;


-- ALTER TABLE Quizzes 
-- ADD CONSTRAINT quizzes_ibfk_1 FOREIGN KEY (courseid) REFERENCES Courses(courseid),
-- ADD CONSTRAINT quizzes_ibfk_2 FOREIGN KEY (studentid) REFERENCES Students(studentid);

-- ALTER TABLE Quizzes
-- ADD COLUMN quiznumber INT;


-- ALTER TABLE assignments
-- ADD COLUMN assignmentnumber INT;


-- ALTER TABLE assignments
-- ADD COLUMN assignmentnumber INT;

-- ALTER TABLE assignments DROP FOREIGN KEY assignments_ibfk_1;
-- ALTER TABLE assignments DROP FOREIGN KEY assignments_ibfk_2;


-- ALTER TABLE assignments DROP INDEX courseid;


-- ALTER TABLE assignments
-- ADD UNIQUE KEY (courseid, studentid, assignmentnumber);

-- SET SQL_SAFE_UPDATES = 0;

-- DELETE a1 FROM assignments a1
-- JOIN assignments a2 
-- ON a1.courseid = a2.courseid 
--   AND a1.studentid = a2.studentid 
--   AND a1.assignmentnumber = a2.assignmentnumber
--   AND a1.assignmentid > a2.assignmentid;

-- SET SQL_SAFE_UPDATES = 1;


-- ALTER TABLE assignments 
-- ADD CONSTRAINT assignments_ibfk_1 FOREIGN KEY (courseid) REFERENCES Courses(courseid)

-- alter table assignments
-- ADD CONSTRAINT assignments_ibfk_2 FOREIGN KEY (studentid) REFERENCES Students(studentid);

-- ALTER TABLE midterms DROP FOREIGN KEY midterms_ibfk_1;
-- ALTER TABLE midterms DROP FOREIGN KEY midterms_ibfk_2;


-- ALTER TABLE midterms DROP INDEX courseid;

-- ALTER TABLE Midterms
-- ADD UNIQUE KEY (courseid, studentid, midnumber);

-- ALTER TABLE midterms 
-- ADD CONSTRAINT midterms_ibfk_1 FOREIGN KEY (courseid) REFERENCES Courses(courseid)


-- ADD CONSTRAINT midterms_ibfk_2 FOREIGN KEY (studentid) REFERENCES Students(studentid);





-- Alter table Midterms 
-- add column midnumber int;

-- ALTER TABLE assignments
-- DROP FOREIGN KEY assignments_ibfk_1;

-- ALTER TABLE assignments
-- ADD CONSTRAINT assignments_ibfk_1
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;


-- ALTER TABLE attendance
-- DROP FOREIGN KEY attendance_ibfk_1;

-- ALTER TABLE attendance
-- ADD CONSTRAINT attendance_ibfk_1
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;


-- ALTER TABLE enrollments
-- DROP FOREIGN KEY enrollments_ibfk_1;

-- ALTER TABLE enrollments
-- ADD CONSTRAINT enrollments_ibfk_2
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;


-- ALTER TABLE finals
-- DROP FOREIGN KEY finals_ibfk_1;


-- ALTER TABLE finals
-- ADD CONSTRAINT finals_ibfk_1
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;

-- ALTER TABLE midterms
-- DROP FOREIGN KEY midterms_ibfk_1;


-- ALTER TABLE midterms
-- ADD CONSTRAINT midterms_ibfk_1
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;

-- ALTER TABLE quizzes
-- DROP FOREIGN KEY quizzes_ibfk_1;


-- ALTER TABLE quizzes
-- ADD CONSTRAINT quizzes_ibfk_1
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;

-- DELIMITER //

-- CREATE TRIGGER after_insert_quiz
-- AFTER INSERT ON quizzes
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   -- Quiz total is fixed at 10
--   SET qt = 10;

--   -- Normalize obtained quiz marks
--   SELECT IFNULL (((SUM(obtainedmarks) / SUM(totalmarks)) * 10), 0)
--   INTO qo
--   FROM quizzes
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Get normalized assignment, midterm, and final values
--   SELECT 
--     IFNULL(assignmenttotal, 10), 
--     IFNULL((assignmentobtained / assignmenttotal) * 10, 0),
--     IFNULL(midtermtotal, 30), 
--     IFNULL((midtermobtained / midtermtotal) * 30, 0),
--     IFNULL(finaltotal, 50), 
--     IFNULL((finalobtained / finaltotal) * 50, 0)
--   INTO 
--     at, ao, mt, mo, ft, fo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Compute total and obtained
--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   -- Compute grade
--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   -- Upsert into grades
--   INSERT INTO grades (studentid, courseid, quiztotal, quizobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, qt, qo, total, grade)
--   ON DUPLICATE KEY UPDATE
--     quiztotal = qt,
--     quizobtained = qo,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;


-- DELIMITER //

-- CREATE TRIGGER after_insert_assignment
-- AFTER INSERT ON assignments
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   -- Assignment total is fixed at 10
--   SET at = 10;

--   -- Normalize obtained assignment marks
--   SELECT IFNULL((SUM(obtainedmarks) / SUM(totalmarks)) * 10, 0)
--   INTO ao
--   FROM assignments
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Get existing normalized values
--   SELECT 
--     IFNULL(quiztotal, 10), 
--     IFNULL(quizobtained, 0),
--     IFNULL(midtermtotal, 30), 
--     IFNULL((midtermobtained / midtermtotal) * 30, 0),
--     IFNULL(finaltotal, 50), 
--     IFNULL((finalobtained / finaltotal) * 50, 0)
--   INTO 
--     qt, qo, mt, mo, ft, fo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Compute totals
--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   -- Compute grade
--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   -- Upsert into grades
--   INSERT INTO grades (studentid, courseid, assignmenttotal, assignmentobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, at, ao, total, grade)
--   ON DUPLICATE KEY UPDATE
--     assignmenttotal = at,
--     assignmentobtained = ao,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;


-- DELIMITER //

-- CREATE TRIGGER after_insert_midterm
-- AFTER INSERT ON midterms
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   -- Midterm total is fixed at 30
--   SET mt = 30;

--   -- Normalize obtained midterm marks
--   SELECT IFNULL((SUM(obtainedmarks) / SUM(totalmarks)) * 30, 0)
--   INTO mo
--   FROM midterms
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Get existing normalized values
--   SELECT 
--     IFNULL(quiztotal, 10), 
--     IFNULL(quizobtained, 0),
--     IFNULL(assignmenttotal, 10), 
--     IFNULL(assignmentobtained, 0),
--     IFNULL(finaltotal, 50), 
--     IFNULL((finalobtained / finaltotal) * 50, 0)
--   INTO 
--     qt, qo, at, ao, ft, fo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Compute totals
--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   -- Compute grade
--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   -- Upsert into grades
--   INSERT INTO grades (studentid, courseid, midtermtotal, midtermobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, mt, mo, total, grade)
--   ON DUPLICATE KEY UPDATE
--     midtermtotal = mt,
--     midtermobtained = mo,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;


-- DELIMITER //

-- CREATE TRIGGER after_insert_final
-- AFTER INSERT ON finals
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   -- Final total is fixed at 50
--   SET ft = 50;

--   -- Normalize obtained final marks
--   SELECT IFNULL((SUM(obtainedmarks) / SUM(totalmarks)) * 50, 0)
--   INTO fo
--   FROM finals
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Get existing normalized values
--   SELECT 
--     IFNULL(quiztotal, 10), 
--     IFNULL(quizobtained, 0),
--     IFNULL(assignmenttotal, 10), 
--     IFNULL(assignmentobtained, 0),
--     IFNULL(midtermtotal, 30), 
--     IFNULL(midtermobtained, 0)
--   INTO 
--     qt, qo, at, ao, mt, mo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   -- Compute totals
--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   -- Compute grade
--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   -- Upsert into grades
--   INSERT INTO grades (studentid, courseid, finaltotal, finalobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, ft, fo, total, grade)
--   ON DUPLICATE KEY UPDATE
--     finaltotal = ft,
--     finalobtained = fo,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;


-- DELIMITER //

-- CREATE TRIGGER after_update_quiz
-- AFTER UPDATE ON quizzes
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   SET qt = 10;

--   SELECT IFNULL((SUM(obtainedmarks) / SUM(totalmarks)) * 10, 0)
--   INTO qo
--   FROM quizzes
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SELECT 
--     IFNULL(assignmenttotal, 10), 
--     IFNULL((assignmentobtained / assignmenttotal) * 10, 0),
--     IFNULL(midtermtotal, 30), 
--     IFNULL((midtermobtained / midtermtotal) * 30, 0),
--     IFNULL(finaltotal, 50), 
--     IFNULL((finalobtained / finaltotal) * 50, 0)
--   INTO 
--     at, ao, mt, mo, ft, fo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   INSERT INTO grades (studentid, courseid, quiztotal, quizobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, qt, qo, total, grade)
--   ON DUPLICATE KEY UPDATE
--     quiztotal = qt,
--     quizobtained = qo,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;



-- DELIMITER //

-- CREATE TRIGGER after_update_assignment
-- AFTER UPDATE ON assignments
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   SET at = 10;

--   SELECT IFNULL((SUM(obtainedmarks) / SUM(totalmarks)) * 10, 0)
--   INTO ao
--   FROM assignments
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SELECT 
--     IFNULL(quiztotal, 10), 
--     IFNULL(quizobtained, 0),
--     IFNULL(midtermtotal, 30), 
--     IFNULL((midtermobtained / midtermtotal) * 30, 0),
--     IFNULL(finaltotal, 50), 
--     IFNULL((finalobtained / finaltotal) * 50, 0)
--   INTO 
--     qt, qo, mt, mo, ft, fo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   INSERT INTO grades (studentid, courseid, assignmenttotal, assignmentobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, at, ao, total, grade)
--   ON DUPLICATE KEY UPDATE
--     assignmenttotal = at,
--     assignmentobtained = ao,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;


-- DELIMITER //

-- CREATE TRIGGER after_update_midterm
-- AFTER UPDATE ON midterms
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   SET mt = 30;

--   SELECT IFNULL((SUM(obtainedmarks) / SUM(totalmarks)) * 30, 0)
--   INTO mo
--   FROM midterms
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SELECT 
--     IFNULL(quiztotal, 10), 
--     IFNULL(quizobtained, 0),
--     IFNULL(assignmenttotal, 10), 
--     IFNULL(assignmentobtained, 0),
--     IFNULL(finaltotal, 50), 
--     IFNULL((finalobtained / finaltotal) * 50, 0)
--   INTO 
--     qt, qo, at, ao, ft, fo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   INSERT INTO grades (studentid, courseid, midtermtotal, midtermobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, mt, mo, total, grade)
--   ON DUPLICATE KEY UPDATE
--     midtermtotal = mt,
--     midtermobtained = mo,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;


-- DELIMITER //

-- CREATE TRIGGER after_update_final
-- AFTER UPDATE ON finals
-- FOR EACH ROW
-- BEGIN
--   DECLARE qt, qo, at, ao, mt, mo, ft, fo, total, obtained DECIMAL(5,2) DEFAULT 0;
--   DECLARE grade VARCHAR(3);

--   SET ft = 50;

--   SELECT IFNULL((SUM(obtainedmarks) / SUM(totalmarks)) * 50, 0)
--   INTO fo
--   FROM finals
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SELECT 
--     IFNULL(quiztotal, 10), 
--     IFNULL(quizobtained, 0),
--     IFNULL(assignmenttotal, 10), 
--     IFNULL(assignmentobtained, 0),
--     IFNULL(midtermtotal, 30), 
--     IFNULL(midtermobtained, 0)
--   INTO 
--     qt, qo, at, ao, mt, mo
--   FROM grades
--   WHERE studentid = NEW.studentid AND courseid = NEW.courseid;

--   SET total = qt + at + mt + ft;
--   SET obtained = qo + ao + mo + fo;

--   IF obtained >= 89.5 THEN SET grade = 'A+';
--   ELSEIF obtained >= 85.5 THEN SET grade = 'A';
--   ELSEIF obtained >= 81.5 THEN SET grade = 'A-';
--   ELSEIF obtained >= 77.5 THEN SET grade = 'B+';
--   ELSEIF obtained >= 73.5 THEN SET grade = 'B';
--   ELSEIF obtained >= 69.5 THEN SET grade = 'B-';
--   ELSEIF obtained >= 65.5 THEN SET grade = 'C+';
--   ELSEIF obtained >= 61.5 THEN SET grade = 'C';
--   ELSEIF obtained >= 57.5 THEN SET grade = 'C-';
--   ELSEIF obtained >= 53.5 THEN SET grade = 'D+';
--   ELSEIF obtained >= 49.5 THEN SET grade = 'D';
--   ELSE SET grade = 'F';
--   END IF;

--   INSERT INTO grades (studentid, courseid, finaltotal, finalobtained, totalgrandtotal, lettergrade)
--   VALUES (NEW.studentid, NEW.courseid, ft, fo, total, grade)
--   ON DUPLICATE KEY UPDATE
--     finaltotal = ft,
--     finalobtained = fo,
--     totalgrandtotal = total,
--     lettergrade = grade;
-- END //

-- DELIMITER ;


-- ALTER TABLE assignments
-- DROP FOREIGN KEY assignments_ibfk_1;

-- ALTER TABLE assignments
-- ADD CONSTRAINT assignments_ibfk_1
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;


-- ALTER TABLE grades DROP FOREIGN KEY grades_ibfk_2;

-- ALTER TABLE grades
-- ADD CONSTRAINT grades_ibfk_2
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;


-- ALTER TABLE midterms DROP FOREIGN KEY midterms_ibfk_1;


-- ALTER TABLE midterms
-- ADD CONSTRAINT midterms_ibfk_1
-- FOREIGN KEY (courseid) REFERENCES courses(courseid)
-- ON DELETE CASCADE;


-- ALTER TABLE transcripts DROP FOREIGN KEY transcripts_ibfk_2;


-- ALTER TABLE transcripts
-- ADD CONSTRAINT transcripts_ibfk_2
-- FOREIGN KEY (courseid) REFERENCES courses(courseid) ON DELETE CASCADE;




