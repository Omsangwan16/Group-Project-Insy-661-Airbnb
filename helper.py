def read_queries_from_file(filename):
    with open(filename, "r") as file:
        lines = file.readlines()

    queries = []
    current_query = {"title": "", "business_objective": "", "query": ""}
    for line in lines:
        line = line.strip()
        # print("Line:", line)  # Print the current line for debugging
        if line.startswith("Title:"):
            current_query["title"] = line.replace("Title:", "").strip()
        elif line.startswith("Business Objective:"):
            current_query["business_objective"] = line.replace(
                "Business Objective:", ""
            ).strip()
        elif line.replace("/", "").replace("*", "").strip() != "":
            current_query["query"] += line + " "
        elif current_query["title"] and current_query["query"]:
            queries.append(current_query.copy())
            current_query = {"title": "", "business_objective": "", "query": ""}

    return queries


def get_queries():
    query_codes = [
        """
SELECT * 
FROM amenity 
WHERE PropertyID = 7;
""",
        """
SELECT COUNT(*)
FROM property p JOIN listings l ON p.PropertyID=l.PropertyID 
WHERE p.Bedrooms>=2;
""",
        """
SELECT h1.hostID from host h1 WHERE h1.HostID IN ( SELECT HostID FROM (SELECT h.HostID,h.ResponseRate, COUNT(h.HostID) AS languageno, 
AVG(r.Rating) AS avgr FROM host h JOIN hostlanguages hl ON h.HostID=hl.HostID JOIN listings l ON h.HostID=l.HostID 
JOIN reviews r ON l.ListingID= r.ListingID GROUP BY h.HostID HAVING h.ResponseRate>=80 AND languageno>=2 AND avgr>=4.5
) AS superhost);



""",
        """
SELECT SUM(Amount) 
FROM payment 
WHERE BookingID = 32;
""",
        """
SELECT * 
FROM messages 
WHERE (SenderID = 66 AND RecipientID = 2);
""",
        """
SELECT l.ListingID, AVG(rating) AS AverageRating, COUNT(r.ReviewID) AS ReviewCount 
FROM listings l LEFT JOIN reviews r ON l.ListingID = r.ListingID 
GROUP BY l.ListingID;
""",
        """
SELECT City, COUNT(*) AS ListingCount 
FROM property 
GROUP BY City 
ORDER BY ListingCount DESC;
""",
        """
SELECT p.City, COUNT(b.BookingID) AS BookingCount
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
JOIN booking b ON l.ListingID = b.ListingID
GROUP BY p.City
ORDER BY BookingCount DESC;
""",
        """
SELECT p.City, AVG(l.PriceperNight) AS AvgPricePerNight
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
GROUP BY p.City;

""",
        """
SELECT h.HostID, h.UserID, COUNT(p.PropertyID) AS PropertyCount
FROM host h
LEFT JOIN property p ON h.HostID = p.HostID
GROUP BY h.HostID, h.UserID;

""",
        """
SELECT u.UserID, u.Username, COUNT(b.BookingID) AS BookingCount
FROM user u
JOIN booking b ON u.UserID = b.GuestUserID
GROUP BY u.UserID, u.Username
ORDER BY BookingCount DESC
LIMIT 1;

""",
        """
SELECT h.HostID, COUNT(l.ListingID) AS ListingCount
FROM host h
LEFT JOIN listings l ON h.HostID = l.HostID
GROUP BY h.HostID
ORDER BY ListingCount DESC
LIMIT 10;
""",
        """
SELECT PaymentMethod, AVG(Amount) AS AvgPaymentAmount
FROM payment
GROUP BY PaymentMethod;
""",
        """
SELECT h.HostID, COUNT(p.PropertyID) AS AirbnbPlusCount
FROM host h
JOIN property p ON h.HostID = p.HostID
WHERE p.AirbnbPlus = TRUE
GROUP BY h.HostID
HAVING AirbnbPlusCount > 1;

""",
        """
SELECT m.MessageID, m.Text, m.Time, u1.Username AS Sender, u2.Username AS Recipient FROM messages m
JOIN user u1 ON m.SenderID = u1.UserID
JOIN user u2 ON m.RecipientID = u2.UserID
WHERE u1.UserID IN (SELECT DISTINCT HostID FROM host)
AND u2.UserID IN (SELECT DISTINCT GuestUserID FROM booking);
""",
        """
SELECT p.PropertyID, p.Address, COUNT(r.ReviewID) AS ReviewCount
FROM property p
LEFT JOIN listings l ON p.PropertyID = l.PropertyID
LEFT JOIN reviews r ON l.ListingID = r.ListingID
GROUP BY p.PropertyID, p.Address
ORDER BY ReviewCount DESC
LIMIT 3;
""",
        """
SELECT p.City, AVG(DATEDIFF(b.CheckOutDate, b.CheckInDate)) AS AvgStayDuration
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
JOIN booking b ON l.ListingID = b.ListingID
GROUP BY p.City;

""",
        """
SELECT p.Category, (SUM(DATEDIFF(b.CheckOutDate, b.CheckInDate)) / (SUM(p.Bedrooms) * 30)) * 100 AS OccupancyRate
FROM property p
JOIN listings l ON p.PropertyID = l.PropertyID
JOIN booking b ON l.ListingID = b.ListingID
GROUP BY p.Category;

""",
        """
SELECT u.UserID, u.Username
FROM user u
LEFT JOIN booking b ON u.UserID = b.GuestUserID
WHERE b.BookingID IS NULL;

""",
        """
SELECT h.HostID, SUM(l.PriceperNight) AS TotalRevenue
FROM host h
JOIN listings l ON h.HostID = l.HostID
JOIN booking b ON l.ListingID = b.ListingID
JOIN payment pay ON b.BookingID = pay.BookingID
GROUP BY h.HostID
ORDER BY TotalRevenue DESC
LIMIT 5;
""",
    ]
    return query_codes


# Read queries from the file
filename = "query.sql"
queries = read_queries_from_file(filename)
print("Queries:", queries[8])  # Print the queries list for debugging

# Print the queries
# print_queries(queries)
