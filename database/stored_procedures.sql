-- Add a New Member
DELIMITER //
CREATE PROCEDURE AddNewMember(
    IN p_MemberName VARCHAR(25),
    IN p_MemberEmail VARCHAR(50),
    IN p_PhoneNumber VARCHAR(15)
)
BEGIN
    INSERT INTO member (MemberName, MemberEmail, PhoneNumber)
    VALUES (p_MemberName, p_MemberEmail, p_PhoneNumber);
END //
DELIMITER ;

-- Retrieve Member Borrow History
DELIMITER //
CREATE PROCEDURE GetMemberBorrowHistory(
    IN p_MemberID INT
)
BEGIN
    SELECT i.Title, b.StartDate, b.ReturnDate
    FROM borrows b
    JOIN item i ON b.ItemID = i.ItemID
    WHERE b.MemberID = p_MemberID;
END //
DELIMITER ;

-- List the Most Borrowed Items
DELIMITER //
CREATE PROCEDURE GetMostBorrowedItems()
BEGIN
    SELECT i.Title, COUNT(b.ItemID) AS BorrowCount
    FROM borrows b
    JOIN item i ON b.ItemID = i.ItemID
    GROUP BY i.Title
    ORDER BY BorrowCount DESC
    LIMIT 5;
END //
DELIMITER ;

-- Track Items with Low Copies
DELIMITER //
CREATE PROCEDURE GetLowStockItems()
BEGIN
    SELECT Title, Copies FROM item WHERE Copies < 2;
END //
DELIMITER ;

-- Add a New Event
DELIMITER //
CREATE PROCEDURE AddNewEvent(
    IN p_EventName VARCHAR(50),
    IN p_EventDate DATE,
    IN p_EventTime TIME,
    IN p_EventLocation VARCHAR(50)
)
BEGIN
    INSERT INTO event (EventName, EventDate, EventTime, EventLocation)
    VALUES (p_EventName, p_EventDate, p_EventTime, p_EventLocation);
END //
DELIMITER ;

-- Testing Procedures

-- Test Adding a New Member
CALL AddNewMember('John Doe', 'john.doe@gmail.com', '555-123-4567');
SELECT * FROM member WHERE MemberName = 'John Doe';

-- Test Retrieving Member Borrow History
CALL GetMemberBorrowHistory(100001);

-- Test Retrieving Low Stock Items
CALL GetLowStockItems();

-- Test Adding a New Event
CALL AddNewEvent('Book Fair', '2024-09-10', '10:00:00', 'Community Hall');
SELECT * FROM event WHERE EventName = 'Book Fair';

