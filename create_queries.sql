CREATE TABLE User(
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Email VARCHAR(255),
    Password VARCHAR(255),
    DateOfBirth DATE,
    ContactInformation VARCHAR(255)
);
CREATE TABLE Host(
    HostID INT PRIMARY KEY,
    Host_Since DATE,
    About TEXT,
    HostingAvailability BOOLEAN,
    ResponseRate DECIMAL(5, 2),
    Superhost BOOLEAN,
    UserID INT,
    FOREIGN KEY(UserID) REFERENCES User(UserID)
);
CREATE TABLE HostLanguages(
    LanguageName VARCHAR(255),
    HostID INT,
    FOREIGN KEY(HostID) REFERENCES Host(HostID),
    PRIMARY KEY(HostID, LanguageName)
);
CREATE TABLE Property(
    PropertyID INT PRIMARY KEY,
    Address TEXT,
    City VARCHAR(255),
    State VARCHAR(255),
    Zip VARCHAR(10),
    Category VARCHAR(30),
    Bedrooms INT,
    Bathrooms INT,
    AirbnbPlus BOOLEAN,
    HostID INT,
    FOREIGN KEY(HostID) REFERENCES Host(HostID)
);
CREATE TABLE Listings(
    ListingID INT PRIMARY KEY,
    Title VARCHAR(255),
    Description TEXT,
    PriceperNight DECIMAL(10, 2),
    HostID INT,
    PropertyID INT,
    FOREIGN KEY(HostID) REFERENCES Host(HostID),
    FOREIGN KEY(PropertyID) REFERENCES Property(PropertyID)
);
CREATE TABLE Booking(
    BookingID INT PRIMARY KEY,
    CheckInDate DATE,
    CheckOutDate DATE,
    Guests INT,
    GuestUserID INT,
    ListingID INT,
    FOREIGN KEY(GuestUserID) REFERENCES User(UserID),
    FOREIGN KEY(ListingID) REFERENCES Listings(ListingID)
);
CREATE TABLE Reviews(
    ReviewID INT PRIMARY KEY,
    Rating INT,
    Comments TEXT,
    ListingID INT,
    UserID INT,
    FOREIGN KEY(ListingID) REFERENCES Listings(ListingID),
    FOREIGN KEY(UserID) REFERENCES User(UserID)
);
CREATE TABLE Payment(
    PaymentID INT PRIMARY KEY,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(255),
    TransactionDate DATE,
    BookingID INT,
    FOREIGN KEY(BookingID) REFERENCES Booking(BookingID)
);
CREATE TABLE Messages(
    MessageID INT PRIMARY KEY,
    Text TEXT,
    Time TIMESTAMP,
    SenderID INT,
    RecipientID INT,
    FOREIGN KEY(SenderID) REFERENCES User(UserID),
    FOREIGN KEY(RecipientID) REFERENCES User(UserID)
);
CREATE TABLE Photos(
    PhotoID INT PRIMARY KEY,
    URL_Image TEXT,
    ListingID INT,
    FOREIGN KEY(ListingID) REFERENCES Listings(ListingID)
);
CREATE TABLE Amenity(
    AmenityID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    PropertyID INT,
    FOREIGN KEY(PropertyID) REFERENCES Property(PropertyID)
);