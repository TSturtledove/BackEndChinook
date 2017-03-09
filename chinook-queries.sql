-- 1.Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT FirstName, LastName, CustomerId, Country
FROM Customer
WHERE Country <> "USA";

-- 2.Provide a query only showing the Customers from Brazil.
SELECT *
FROM Customer
WHERE Country = "Brazil";

-- 3.Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM Invoice i, Customer c
WHERE i.CustomerId = c.CustomerId AND c.Country = "Brazil";

-- 4.Provide a query showing only the Employees who are Sales Agents.
SELECT *
FROM Employee
WHERE Title = "Sales Support Agent";

-- 5.Provide a query showing a unique list of billing countries from the Invoice table.
SELECT BillingCountry
FROM Invoice
GROUP BY BillingCountry;

-- 6.Provide a query showing the invoices of customers who are from Brazil.
SELECT i.InvoiceId, i.CustomerId, i.InvoiceDate, i.BillingAddress, i.BillingCity, i.BillingState, i.BillingCountry, i.BillingPostalCode, i.Total
FROM Invoice i
LEFT JOIN Customer c
WHERE i.CustomerId = c.CustomerId AND c.Country = "Brazil";

-- 7.Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT i.InvoiceId, i.CustomerId, i.InvoiceDate, i.BillingAddress, i.BillingCity, i.BillingState, i.BillingCountry,
i.BillingPostalCode, i.Total, e.FirstName AS "Rep First Name", e.LastName AS "Rep Last Name"
FROM Invoice i
LEFT JOIN Customer c
LEFT JOIN Employee e
WHERE i.CustomerId = c.CustomerId AND c.SupportRepId = e.EmployeeId;

-- 8.Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT i.Total, c.FirstName AS "Customer First Name", c.LastName AS "Customer Last Name", c.Country, e.FirstName AS "Rep First Name",
e.LastName AS "Rep Last Name"
FROM Invoice i
LEFT JOIN Customer c
LEFT JOIN Employee e
WHERE i.CustomerId = c.CustomerId AND c.SupportRepId = e.EmployeeId;

-- 9.How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT COUNT(InvoiceId) AS "Number of invocies", SUM(Total), strftime("%Y", InvoiceDate) AS Year
FROM Invoice
WHERE Year = "2009" OR Year = "2011"
GROUP BY Year
ORDER BY InvoiceDate DESC;


--WHERE strftime("%Y", InvoiceDate) = "2009" --use this method to search for a string alone


-- 10.Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT() AS "Number of line items for Invoice ID 37"
FROM InvoiceLine
WHERE InvoiceId = "37";


-- 11.Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT COUNT() AS "Number of line items", InvoiceId
FROM InvoiceLine
GROUP BY InvoiceId;


-- 12.Provide a query that includes the track name with each invoice line item.
SELECT i.InvoiceLineId AS "LineId", i.InvoiceId, t.Name AS "Track Name", i.UnitPrice, i.Quantity
FROM InvoiceLine i
LEFT JOIN Track t
WHERE i.TrackId = t.TrackId;


-- 13.Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT i.InvoiceLineId AS "LineId", i.InvoiceId, t.Name AS "Track Name", a.Name AS "Artist", i.UnitPrice, i.Quantity
FROM InvoiceLine i, Track t
JOIN Album ON Album.AlbumId = t.AlbumId
JOIN Artist a ON a.ArtistId = Album.ArtistId
WHERE i.TrackId = t.TrackId;


-- 14.Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT COUNT() AS "Number of Invoices", BillingCountry AS "Country"
FROM Invoice
GROUP BY BillingCountry;


-- 15.Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.
SELECT COUNT() AS "Number of Tracks", p.Name AS "Playlist Name"
FROM PlaylistTrack t
JOIN Playlist p ON p.PlaylistId = t.PlaylistId
GROUP BY t.PlaylistId;


-- 16.Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT t.Name AS "Track", a.Title AS "Album", m.Name AS "MediaType", g.Name AS "Genre"
FROM Track t
JOIN Album a ON a.AlbumId = t.AlbumId
JOIN MediaType m ON m.MediaTypeId = t.MediaTypeId
JOIN Genre g ON g.GenreId = t.GenreId;


-- 17.Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT i.*, COUNT(l.InvoiceLineId) AS "Number of Invoice line items"
FROM Invoice i
JOIN InvoiceLine l ON l.InvoiceId =i.InvoiceId
GROUP BY i.InvoiceId;


-- 18.Provide a query that shows total sales made by each sales agent.
SELECT e.FirstName AS "FirstName", e.LastName AS "LastName", SUM(i.Total) AS "Total Sales"
FROM Invoice i
JOIN Customer c ON c.CustomerId = i.CustomerId
JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY c.SupportRepId;


-- 19.Which sales agent made the most in sales in 2009? Steve Johnson
SELECT e.FirstName AS "FirstName", e.LastName AS "LastName", SUM(i.Total) AS "Total Sales"
FROM Invoice i
JOIN Customer c ON c.CustomerId = i.CustomerId
JOIN Employee e ON e.EmployeeId = c.SupportRepId
WHERE InvoiceDate BETWEEN "2009-01-01" AND "2009-12-31"
GROUP BY c.SupportRepId
ORDER BY SUM(i.Total) DESC
LIMIT 1;


-- 20.Which sales agent made the most in sales in 2010? Jane Peacock
SELECT e.FirstName AS "FirstName", e.LastName AS "LastName", SUM(i.Total) AS "Total Sales"
FROM Invoice i
JOIN Customer c ON c.CustomerId = i.CustomerId
JOIN Employee e ON e.EmployeeId = c.SupportRepId
WHERE InvoiceDate BETWEEN "2010-01-01" AND "2010-12-31"
GROUP BY c.SupportRepId
ORDER BY SUM(i.Total) DESC
LIMIT 1;


-- 21.Which sales agent made the most in sales over all? Jane Peacock
SELECT e.FirstName AS "FirstName", e.LastName AS "LastName", SUM(i.Total) AS "Total Sales"
FROM Invoice i
JOIN Customer c ON c.CustomerId = i.CustomerId
JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY c.SupportRepId
ORDER BY SUM(i.Total) DESC
LIMIT 1;


-- 22.Provide a query that shows the # of customers assigned to each sales agent.
SELECT e.FirstName AS "FirstName", e.LastName AS "LastName", SUM(c.CustomerId) AS "Number of Customers"
FROM Customer c
JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY c.SupportRepId;


-- 23.Provide a query that shows the total sales per country. Which country's customers spent the most?
SELECT SUM(Total), BillingCountry
FROM Invoice
GROUP BY BillingCountry
ORDER BY SUM(Total) DESC;


-- 24.Provide a query that shows the most purchased track of 2013.
SELECT t.Name AS "Track Name", COUNT(i.TrackId) AS "Times Purchased"
FROM InvoiceLine i
JOIN Track t ON t.TrackId = i.TrackId
JOIN Invoice ON Invoice.InvoiceId = i.InvoiceId
WHERE Invoice.InvoiceDate BETWEEN "2013-01-01" AND "2013-12-31"
GROUP BY i.TrackId;


-- 25.Provide a query that shows the top 5 most purchased tracks over all.
SELECT t.Name AS "Track Name", COUNT(i.TrackId) AS "Times Purchased"
FROM InvoiceLine i
JOIN Track t ON t.TrackId = i.TrackId
GROUP BY i.TrackId
ORDER BY COUNT(i.TrackId) DESC
LIMIT 5;

-- 26.Provide a query that shows the top 3 best selling artists.
Artist to Album to track, count tracks, group by artist
SELECT r.Name AS "Artist Name", COUNT(i.TrackId) AS "Number of tracks sold"
FROM InvoiceLine i
JOIN Track t ON t.TrackId = i.TrackId
JOIN Album a ON a.AlbumId = t.AlbumId
JOIN Artist r ON r.ArtistId = a.ArtistId
GROUP BY r.ArtistId
ORDER BY COUNT(i.TrackId) DESC
LIMIT 3;


-- 27.Provide a query that shows the most purchased Media Type.
SELECT m.Name AS "Most Purchased Media Type", COUNT(i.TrackId) AS "Number of tracks sold in this type"
FROM InvoiceLine i
JOIN Track t ON t.TrackId = i.TrackId
JOIN MediaType m ON m.MediaTypeId = t.MediaTypeId
GROUP BY m.MediaTypeId
ORDER BY COUNT(i.TrackId) DESC
LIMIT 1;
