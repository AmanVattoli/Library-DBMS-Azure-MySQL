-- List the Most Borrowed Items
SELECT i.Title, COUNT(b.ItemID) AS BorrowCount
FROM borrows b
JOIN item i ON b.ItemID = i.ItemID
GROUP BY i.Title
ORDER BY BorrowCount DESC
LIMIT 5;

-- Find Members with the Highest Number of Borrows
SELECT m.MemberName, COUNT(b.ItemID) AS TotalBorrows
FROM member m
JOIN borrows b ON m.MemberID = b.MemberID
GROUP BY m.MemberName
ORDER BY TotalBorrows DESC
LIMIT 5;

-- Find the Most Popular Genre Based on Borrowing Activity
SELECT g.IGenre, COUNT(b.ItemID) AS BorrowCount
FROM genre g
JOIN borrows b ON g.ItemID = b.ItemID
GROUP BY g.IGenre
ORDER BY BorrowCount DESC
LIMIT 1;

-- Get Borrowing History for a Specific Member
SELECT i.Title, b.StartDate, b.ReturnDate
FROM borrows b
JOIN item i ON b.ItemID = i.ItemID
JOIN member m ON b.MemberID = m.MemberID
WHERE m.MemberName = 'Ray Walker';

-- Calculate the Average Borrow Duration (in Days)
SELECT AVG(DATEDIFF(ReturnDate, StartDate)) AS AvgBorrowDuration
FROM borrows;

-- Find the Top 5 Authors Whose Books Are Borrowed the Most
SELECT a.AutName, COUNT(b.ItemID) AS BorrowCount
FROM borrows b
JOIN authors a ON b.ItemID = a.ItemID
GROUP BY a.AutName
ORDER BY BorrowCount DESC
LIMIT 5;

-- Find Items with Low Copy Count (Less than 2 Copies)
SELECT Title, Copies FROM item WHERE Copies < 2;

-- Identify Members Who Have Borrowed from Multiple Genres
SELECT m.MemberName, COUNT(DISTINCT g.IGenre) AS GenreCount
FROM borrows b
JOIN member m ON b.MemberID = m.MemberID
JOIN genre g ON b.ItemID = g.ItemID
GROUP BY m.MemberName
HAVING GenreCount > 3;

-- Find Staff Members Who Have Hosted More Than 5 Events
SELECT s.StaffName, COUNT(h.EventID) AS EventCount
FROM hosts h
JOIN staff s ON h.StaffID = s.StaffID
GROUP BY s.StaffName
HAVING EventCount > 5;

-- Sort Events by Date
SELECT eventName, eventDate, eventTime FROM event ORDER BY eventDate;

-- Sort Staff by Name
SELECT staffName FROM staff ORDER BY staffName;

-- List Distinct Item Types
SELECT DISTINCT ItemType FROM item;

-- Sort Members by Name and Show Emails
SELECT MemberName, MemberEmail FROM member ORDER BY MemberName;

-- Count Books Borrowed by Each Member
SELECT MemberName AS Member, COUNT(*) AS Number_of_Books_Borrowed
FROM borrows b JOIN member m ON b.MemberID = m.MemberID
GROUP BY MemberName;

-- Count Total Items in Each Genre
SELECT g.IGenre, COUNT(*) AS Total_Items
FROM genre g JOIN item i ON g.ItemID = i.ItemID
GROUP BY g.IGenre;

-- Show Members Who Borrowed More Than One Book
SELECT m.MemberName, COUNT(b.ItemID) AS Books_Borrowed
FROM member m JOIN borrows b ON m.MemberID = b.MemberID
GROUP BY m.MemberName
HAVING COUNT(b.ItemID) > 1;

-- Show All Members Who Borrowed a Specific Item
SELECT m.MemberName, i.Title
FROM borrows b
JOIN member m ON b.MemberID = m.MemberID
JOIN item i ON b.ItemID = i.ItemID
WHERE i.Title = 'Introduction to Algorithms';



