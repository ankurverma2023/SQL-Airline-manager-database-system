CREATE DATABASE AIRLINEMANAGERDB
USE AIRLINEMANAGERDB

--The Airline Manager Database System (AMDS) is a SQL-based solution for managing airline operations,
--including flights, passengers, and performance tracking. It provides real-time insights, ensures data integrity,
--and optimizes flight scheduling and passenger management

CREATE TABLE Flights
(
FlightID INT PRIMARY KEY,
FlightNumber VARCHAR(10),
Origin VARCHAR(50),
Destination VARCHAR(50),
DepartureTime DATETIME,
ArrivalTime DATETIME,
Status VARCHAR(20)
)
INSERT INTO Flights VALUES(1,'AI101','New York','London','2025-01-05 08:00:00','2025-01-05 20:00:00','Scheduled'),
(2,'AI202','London','Paris','2025-01-06 10:00:00','2025-01-06 12:00:00','Delayed'),
(3,'AI303','Paris','Berlin','2025-01-07 14:00:00', '2025-01-07 16:00:00', 'Cancelled')

SELECT * FROM Flights

CREATE TABLE Passengers
(
PassengerID INT PRIMARY KEY,
Name VARCHAR(100),
FlightID INT,
SeatNumber VARCHAR(10),
BookingDate DATETIME,
FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
)
INSERT INTO Passengers VALUES(1,'Alice Johnson',1,'12A','2025-01-01 09:00:00'),
(2,'Bob Smith',1,'12B','2025-01-01 09:10:00'),
(3,'Charlie Brown',2,'14C','2025-01-03 15:00:00')

SELECT * FROM Passengers

--Find all scheduled flights from a specific city.
--Question: Write a query to list all scheduled flights originating from New York.

SELECT * FROM Flights
WHERE Origin = 'New York' AND Status = 'Scheduled'

--Count the number of passengers for each flight.
--Question: How many passengers are booked for each flight?

SELECT FlightID, COUNT(*) AS PassengerCount
FROM Passengers
GROUP BY FlightID

--Identify passengers of a delayed flight.
--Question: List all passengers for flights with status 'Delayed.

SELECT p.Name, p.SeatNumber, f.FlightNumber
FROM Passengers P
JOIN Flights f ON P.FlightID = F.FlightID
WHERE F.Status = 'Delayed'

--Find the most recent booking.
--Question: Who booked their ticket most recently?

SELECT TOP 1 *
FROM Passengers
ORDER BY BookingDate DESC

--Calculate total flight time.
--Question: What is the total duration of a specific flight?

SELECT FlightNumber,
       DATEDIFF(MINUTE, DepartureTime, ArrivalTime) AS TotalDurationMinutes
FROM Flights
WHERE FlightID = 1

--Find flights with no passengers.
--Question: Which flights have no passengers booked yet?

SELECT f.FlightNumber
FROM Flights f
LEFT JOIN Passengers p ON F.FlightID = P.FlightID
WHERE P.PassengerID IS NULL

--Update flight status.
--Question: A flight got delayed; update its status.

UPDATE Flights
SET Status = 'Delayed'
WHERE FlightID = 3

SELECT * FROM Flights
SELECT * FROM Passengers

--Delete a cancelled flight.
--Question: Remove all records of a cancelled flight from both tables.

DELETE FROM Passengers WHERE FlightID = 3
DELETE FROM Flights WHERE FlightID = 3


--Find overlapping flight schedules.
--Question: Which flights overlap in schedule?

SELECT f1.FlightNumber AS Flight1, f2.FlightNumber AS Flight2
FROM Flights f1
JOIN Flights f2 ON f1.FlightID <> f2.FlightID
WHERE f1.DepartureTime < f2.ArrivalTime AND f1.ArrivalTime > f2.DepartureTime


