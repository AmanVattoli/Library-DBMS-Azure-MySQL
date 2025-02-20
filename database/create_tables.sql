-- Publisher Table: Stores information about publishers who produce books, films, or music.
CREATE TABLE publisher (
    PublisherID INT NOT NULL,
    PublisherName VARCHAR(50) NOT NULL,
    PRIMARY KEY(PublisherID),
    UNIQUE (PublisherID, PublisherName)
);

-- Item Table: Stores details about library items, including books, films, and music.
CREATE TABLE item (
    ItemID INT NOT NULL,
    Title VARCHAR(50) NOT NULL,
    ItemLanguage VARCHAR(30),
    PublisherNum INT NOT NULL,
    Copies INT NOT NULL,
    PRIMARY KEY(ItemID),
    FOREIGN KEY(PublisherNum) REFERENCES publisher(PublisherID)
);

-- Genre Table: Associates items with their respective genres.
CREATE TABLE genre (
    ItemID INT NOT NULL,
    IGenre VARCHAR(15) NOT NULL,
    PRIMARY KEY(ItemID, IGenre),
    FOREIGN KEY(ItemID) REFERENCES item(ItemID)
);

-- Authors Table: Links items books to their authors.
CREATE TABLE authors (
    ItemID INT NOT NULL,
    AutName VARCHAR(30) NOT NULL,
    PRIMARY KEY(ItemID, AutName),
    FOREIGN KEY(ItemID) REFERENCES item(ItemID)
);

-- Member Table: Stores information about library members.
CREATE TABLE member (
    MemberID INT NOT NULL AUTO_INCREMENT,
    MemberName VARCHAR(25) NOT NULL,
    MemberEmail VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15),
    PRIMARY KEY(MemberID)
);

-- Staff Table: Stores information about staff members working in the library.
CREATE TABLE staff (
    StaffID INT NOT NULL,
    StaffName VARCHAR(25) NOT NULL,
    StaffEmail VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15),
    PRIMARY KEY(StaffID)
);

-- Event Table: Stores information about events organized by the library.
CREATE TABLE event (
    EventID INT NOT NULL AUTO_INCREMENT,
    EventName VARCHAR(50) NOT NULL,
    EventDate DATE NOT NULL,
    EventTime TIME NOT NULL,
    EventLocation VARCHAR(50) NOT NULL,
    PRIMARY KEY(EventID)
);

-- Borrows Table: Tracks which members borrow which items and their borrow durations.
CREATE TABLE borrows (
    BorrowID INT AUTO_INCREMENT NOT NULL,
    MemberID INT NOT NULL,
    ItemID INT NOT NULL,
    StartDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    PRIMARY KEY(BorrowID),
    FOREIGN KEY(MemberID) REFERENCES member(MemberID),
    FOREIGN KEY(ItemID) REFERENCES item(ItemID)
);

-- Hosts Table: Tracks which staff members are responsible for hosting library events.
CREATE TABLE hosts (
    StaffID INT NOT NULL,
    EventID INT NOT NULL,
    PRIMARY KEY(StaffID, EventID),
    FOREIGN KEY(StaffID) REFERENCES staff(StaffID),
    FOREIGN KEY(EventID) REFERENCES event(EventID)
);

-- Manages Table: Tracks which staff members manage which library members.
CREATE TABLE manages (
    StaffID INT NOT NULL,
    MemberID INT NOT NULL,
    PRIMARY KEY(StaffID, MemberID),
    FOREIGN KEY(StaffID) REFERENCES staff(StaffID),
    FOREIGN KEY(MemberID) REFERENCES member(MemberID)
);

