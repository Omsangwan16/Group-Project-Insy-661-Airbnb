/*
Title: Retrieve all amenities for a specific property.
Business Objective: Display the amenities available for a particular property to help potential guests understand the property's features and offerings.
*/
SELECT * 
FROM amenity 
WHERE PropertyID = 7;


/*
Title: Find the number of listings with more than a certain number of bedrooms.
Business Objective: Determine the count of listings that meet a specific bedroom requirement to assist users in finding properties that suit their accommodation needs.
*/
SELECT COUNT(*) 
FROM Property p 
JOIN listings l ON p.PropertyID=l.PropertyID 
WHERE p.Bedrooms>=2;


/*
Title: Get the superhosts from the data based on an updated criteria, response rate >80% , avg rating of listings > 4.5 and they know at least 2 languages.
Business Objective: Fetch the updated superhosts based on criteria such as response rate, average listing rating, and language proficiency, to identify hosts that offer exceptional guest experiences.
*/
CREATE VIEW superhost AS
SELECT h.HostID,h.ResponseRate, COUNT(h.HostID) AS languageno, 
AVG(r.Rating) AS avgr FROM host h JOIN hostlanguages hl ON h.HostID=hl.HostID JOIN listings l ON h.HostID=l.HostID 
JOIN reviews r ON l.ListingID= r.ListingID GROUP BY h.HostID HAVING h.ResponseRate>=80 AND languageno>=2 AND avgr>=4.5;

UPDATE host h SET Superhost = 0 
WHERE h.HostID NOT IN ( SELECT HostID FROM sh);


/*
Title: Find the total amount paid for a specific booking.
Business Objective: Calculate and display the total payment amount for a specific booking to provide accurate financial records and transparency to guests.
*/
SELECT SUM(Amount) 
FROM payment 
WHERE BookingID = 32;


/*
Title: Retrieve messages sent between two specific users.
Business Objective: Retrieve messages exchanged between two specific users (hosts and guests) to facilitate communication and support between them.
*/

SELECT * 
FROM messages 
WHERE (SenderID = 66 AND RecipientID = 2);


/*
Title: Find the average rating and the number of reviews for each listing.
Business Objective: Calculate and display the average rating and the count of reviews for each listing to help users gauge the quality and popularity of listings.
*/
SELECT l.ListingID, AVG(rating) AS AverageRating, COUNT(r.ReviewID) AS ReviewCount 
FROM listings l LEFT JOIN reviews r ON l.ListingID = r.ListingID 
GROUP BY l.ListingID;    


/*
Title: Get the number of listings in each city and sort the result in descending order.
Business Objective: Obtain the count of listings in each city and sort the cities by the number of listings to identify popular destinations.
*/
SELECT City, COUNT(*) AS ListingCount 
FROM property 
GROUP BY City 
ORDER BY ListingCount DESC;


/*
Title: Rank popular cities based on the amount of bookings.
Business Objective: Rank cities based on the number of bookings to identify popular travel destinations and trends.
*/
SELECT p.City, COUNT(b.BookingID) AS BookingCount
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
JOIN booking b ON l.ListingID = b.ListingID
GROUP BY p.City
ORDER BY BookingCount DESC;



/*
Title: Average Price per Night by City.
Business Objective: Calculate and display the average price per night for listings in each city to help users compare pricing across different locations.
*/
SELECT p.City, AVG(l.PriceperNight) AS AvgPricePerNight
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
GROUP BY p.City;


/*
Title: Retrieve a list of hosts along with the count of properties they own.
Business Objective: Provide a list of hosts along with the count of properties they own to recognize top hosts and understand property ownership distribution.
*/
SELECT h.HostID, h.UserID, COUNT(p.PropertyID) AS PropertyCount
FROM host h
LEFT JOIN property p ON h.HostID = p.HostID
GROUP BY h.HostID, h.UserID;


/*
Title:Identify the user who made the highest number of bookings.
Business Objective: Identify and recognize the user who has made the highest number of bookings, which can be used for rewarding loyal customers or targeted marketing.
*/
SELECT u.UserID, u.Username, COUNT(b.BookingID) AS BookingCount
FROM User u
JOIN Booking b ON u.UserID = b.GuestUserID
GROUP BY u.UserID, u.Username
ORDER BY BookingCount DESC
LIMIT 1;


/*
Title:List Top 10 hosts with the highest number of property listings.
Business Objective: Recognize and showcase the top hosts who have the highest number of property listings, contributing to the platform's diversity and variety.
*/
SELECT h.HostID, COUNT(l.ListingID) AS ListingCount
FROM host h
LEFT JOIN listings l ON h.HostID = l.HostID
GROUP BY h.HostID
ORDER BY ListingCount DESC
LIMIT 10;


/*
Title: Calculate the average payment amount for each payment method.
Business Objective: Calculate the average payment amount for each payment method to understand payment preferences and trends among users.
*/

SELECT PaymentMethod, AVG(Amount) AS AvgPaymentAmount
FROM Payment
GROUP BY PaymentMethod;


/*
Title: Identify hosts with more than one AirbnbPlus property.
Business Objective: Identify hosts who have multiple AirbnbPlus properties to highlight hosts who consistently meet AirbnbPlus standards.
*/
SELECT h.HostID, COUNT(p.PropertyID) AS AirbnbPlusCount
FROM Host h
JOIN Property p ON h.HostID = p.HostID
WHERE p.AirbnbPlus = TRUE
GROUP BY h.HostID
HAVING AirbnbPlusCount > 1;


/*
Title: Fetch messages exchanged between hosts and guests.
Business Objective: Retrieve messages exchanged between hosts and guests to facilitate customer support and enhance the user experience.
*/
SELECT m.MessageID, m.Text, m.Time, u1.Username AS Sender, u2.Username AS Recipient FROM Messages m
JOIN User u1 ON m.SenderID = u1.UserID
JOIN User u2 ON m.RecipientID = u2.UserID
WHERE u1.UserID IN (SELECT DISTINCT HostID FROM host)
AND u2.UserID IN (SELECT DISTINCT GuestUserID FROM booking);


/*
Title: Get the top 3 properties by the number of reviews they've received.
Business Objective: Identify and showcase the top-rated properties based on the number of reviews they've received, indicating customer satisfaction.
*/
SELECT p.PropertyID, p.Address, COUNT(r.ReviewID) AS ReviewCount
FROM property p
LEFT JOIN listings l ON p.PropertyID = l.PropertyID
LEFT JOIN reviews r ON l.ListingID = r.ListingID
GROUP BY p.PropertyID, p.Address
ORDER BY ReviewCount DESC
LIMIT 3;


/*
Title: Calculate the average duration of stay (in days) for each city's listings.
Business Objective: Determine the average duration of stay for listings in each city to help hosts understand typical guest stay patterns.
*/

SELECT p.City, AVG(DATEDIFF(b.CheckOutDate, b.CheckInDate)) AS AvgStayDuration
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
JOIN booking b ON l.ListingID = b.ListingID
GROUP BY p.City;


/*
Title:Calculate the occupancy rate for each property category.
Business Objective: Calculate the occupancy rate for different property categories to evaluate the popularity and utilization of each category.
*/
SELECT p.Category, (SUM(DATEDIFF(b.CheckOutDate, b.CheckInDate)) / (SUM(p.Bedrooms) * 30)) * 100 AS OccupancyRate
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
JOIN booking b ON l.ListingID = b.ListingID
GROUP BY p.Category;


/*
Title: Get users who have registered but haven't made any bookings.
Business Objective: Identify users who have registered on the platform but haven't completed the booking process, which can be useful for targeted marketing or improving user engagement.
*/

SELECT u.UserID, u.Username
FROM user u
LEFT JOIN booking b ON u.UserID = b.GuestUserID
WHERE b.BookingID IS NULL;


/*
Title:The top 5 hosts based on the revenue they are making from all of their properties.
Business Objective: Recognize and showcase the top hosts who generate the highest revenue from their properties, highlighting successful hosts and properties.
*/
SELECT h.HostID, SUM(l.PriceperNight) AS TotalRevenue
FROM host h
JOIN listings l ON h.HostID = l.HostID
JOIN booking b ON l.ListingID = b.ListingID
JOIN payment pay ON b.BookingID = pay.BookingID
GROUP BY h.HostID
ORDER BY TotalRevenue DESC
LIMIT 5;
