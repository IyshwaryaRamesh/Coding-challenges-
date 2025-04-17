--1 database creation
CREATE DATABASE PetPals;
USE PetPals;
--2 table creation
CREATE TABLE Pets (
    PetID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Age INT NOT NULL,
    Breed VARCHAR(255) NOT NULL,
    Type VARCHAR(100) NOT NULL,
    AvailableForAdoption BIT NOT NULL DEFAULT 1
);

CREATE TABLE Shelters (
    ShelterID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    UserType VARCHAR(50) NOT NULL 
);

CREATE TABLE Adoption (
    AdoptionID INT IDENTITY(1,1) PRIMARY KEY,
    PetID INT NOT NULL,
    AdopterID INT NOT NULL,
    AdoptionDate DATETIME NOT NULL,
    FOREIGN KEY (PetID) REFERENCES Pets(PetID),
    FOREIGN KEY (AdopterID) REFERENCES Users(UserID)
);

CREATE TABLE Donations (
    DonationID INT IDENTITY(1,1) PRIMARY KEY,
    DonorName VARCHAR(255) NOT NULL,
    DonationType VARCHAR(100) NOT NULL,
    DonationAmount DECIMAL(10,2) DEFAULT NULL,
    DonationItem VARCHAR(255) DEFAULT NULL,
    DonationDate DATETIME NOT NULL
);

CREATE TABLE AdoptionEvents (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Participants (
    ParticipantID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantName VARCHAR(255) NOT NULL,
    ParticipantType VARCHAR(100) NOT NULL,
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

INSERT INTO Pets (Name, Age, Breed, Type, AvailableForAdoption) 
VALUES('Sher', 3, 'Labrador', 'Dog', 1),
('Muthu', 2, 'Persian', 'Cat', 1),
('Kanna', 5, 'German Shepherd', 'Dog', 0),
('subramani', 1, 'Siamese', 'Cat', 1),
('Tommy', 4, 'Beagle', 'Dog', 1),
('Charlie', 2, 'Bengal', 'Cat', 1),
('Rocky', 3, 'Pug', 'Dog', 0),
('Mimi', 6, 'Maine Coon', 'Cat', 1),
('damu', 4, 'Dachshund', 'Dog', 1),
('Laddu', 2, 'Sphynx', 'Cat', 1);

select * from Pets;

INSERT INTO Shelters (Name, Location) 
VALUES('Ramya Animal Care Center', 'Mettur'),
('Lakshaya Pet Rescue Shelter', 'Avinashi'),
('Madhu Furry Friends Foundation', 'Kinathukaduvu'),
('Nithish Compassionate Paws Trust', 'salem'),
('Ranya Happy Tails Shelter', 'Salem'),
('Madhavi Pet Haven', 'Tirunelveli'),
('Ravi Rescue Center', 'Erode'),
('Lakshmiya Animal Sanctuary', 'Vellore'),
('Nithya Paws and Claws Shelter','Tirupur'),
('Ramani Animal Welfare Society','Kanyakumari');

select * from Shelters;

INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate) 
VALUES
('Arjun', 'Cash', 5000.00, NULL, '2025-03-01 10:00:00'),
('Janaane Iyer', 'Item', NULL, 'Dog Food Bags', '2025-03-02 11:30:00'),
('Suresh', 'Cash', 2000.00, NULL, '2025-03-03 14:15:00'),
('Aditiya', 'Item', NULL, 'Cat Toys', '2025-03-04 09:45:00'),
('Muthu', 'Cash', 10000.00, NULL, '2025-03-05 16:20:00'),
('deepak', 'Item', NULL, 'Leashes and Collars', '2025-03-06 12:10:00'), 
('Kani', 'Cash', 3000.00, NULL, '2025-03-07 08:30:00'), 
('Kir', 'Item', NULL, 'Blankets for Pets', '2025-03-08 17:55:00'), 
('Karthik Subramanian', 'Cash', 1500.00, NULL, '2025-03-09 13:05:00'),
('kali', 'Item', NULL, 'Cat Litter Boxes', '2025-03-10 15:40:00'); 

select * from Donations;

INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES
('Spring Adoption Fair!','2025-04-01 10:00:00','Marina Beach Park'),
('Paw Pet Day','2025-04-15 12:00:00','Anna Nagar'),
('Pet Friends Adoption Drive','2025-04-20 09:30:00','Madurai Mall Grounds'),
('Summer Pet Festival','2025-05-05 11:00:00','Trichy City Hall'),
('Fall in Love with Pets Event!','2025-09-10 14:00:00',' Bangalore'),
('Charity Event for Pets','2025-06-01 09:30:00','Chennai Marina Beach'),
('Adoption Drive at Coimbatore Fair','2025-07-15 10:30:00','Coimbatore Exhibition Center'),
('Pet Awareness Campaign','2025-08-20 11:30:00','Vellore Fort Grounds'),
('Festival of Pets Adoption!','2025-10-05 12:15:00','Salem'),
('New Year Pet Adoption Gala!','2026-01-01 11:15:00','Chennai Convention Center');

select * from AdoptionEvents;


INSERT INTO Participants (ParticipantName, ParticipantType, EventID) 
VALUES 
('Ramya Animal Care Center','Shelter',1),
('Lakshaya Pet Rescue Shelter','Shelter',2),
('Madhu Furry Friends Foundation','Shelter',3),
('Nithish Compassionate Paws Trust','Shelter',4),
('Ranya Happy Tails Shelter ','Shelter ',5),
('Arjun Kumar ','Adopter ',6),
('Priya Iyer ','Adopter ',7),
('Suresh Reddy ','Adopter ',8),
('Anjali Verma ','Adopter ',9),
('Deepak Nair ','Adopter ',10);

select*from Participants;

-- Query 1: Retrieve a list of available pets
SELECT Name, Age, Breed, Type FROM Pets WHERE AvailableForAdoption = 1;

-- Query 2: Retrieve participant names for a specific event
DECLARE @EventID INT = 1; -- Replace with desired EventID
SELECT ParticipantName, ParticipantType 
FROM Participants
WHERE EventID = @EventID;

-- 
DECLARE @EventID INT = 1;
SELECT ParticipantName, ParticipantType 
FROM Participants
WHERE EventID = @EventID;

GO
CREATE PROCEDURE UpdateShelterInfo
    @shelter_id INT,
    @new_name VARCHAR(255),
    @new_location VARCHAR(255)
AS
BEGIN
    UPDATE Shelters
    SET Name = @new_name, Location = @new_location
    WHERE ShelterID = @shelter_id;
END;
GO

SELECT Shelters.Name, COALESCE(SUM(Donations.DonationAmount), 0) AS TotalDonation
FROM Shelters
LEFT JOIN Donations ON Shelters.ShelterID = Donations.DonationID
GROUP BY Shelters.Name;

SELECT Name, Age, Breed, Type FROM Pets WHERE PetID NOT IN (SELECT DISTINCT PetID FROM Adoption);

SELECT FORMAT(DonationDate, 'MMMM yyyy') AS MonthYear, SUM(DonationAmount) AS TotalDonation
FROM Donations
GROUP BY FORMAT(DonationDate, 'MMMM yyyy');

SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 3 OR Age > 5;

SELECT Pets.Name, Pets.Breed, Shelters.Name AS ShelterName
FROM Pets
JOIN Shelters ON Pets.PetID = Shelters.ShelterID
WHERE Pets.AvailableForAdoption = 1;

SELECT COUNT(*) AS TotalParticipants
FROM Participants
JOIN AdoptionEvents ON Participants.EventID = AdoptionEvents.EventID
WHERE AdoptionEvents.Location = 'Chennai';

SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 5;

SELECT * FROM Pets WHERE PetID NOT IN (SELECT DISTINCT PetID FROM Adoption);

SELECT p.Name AS PetName, u.Name AS AdopterName
FROM Pets p
JOIN Adoption a ON p.PetID = a.PetID
JOIN Users u ON a.AdopterID = u.UserID;

SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePets
FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.PetID AND p.AvailableForAdoption = 1
GROUP BY s.Name;

SELECT p1.Name AS Pet1, p2.Name AS Pet2, p1.Breed, s.Name AS ShelterName
FROM Pets p1
JOIN Pets p2 ON p1.Breed = p2.Breed AND p1.PetID < p2.PetID
JOIN Shelters s ON p1.PetID = s.ShelterID;

SELECT Shelters.Name AS ShelterName, AdoptionEvents.EventName
FROM Shelters
CROSS JOIN AdoptionEvents;

SELECT TOP 1 Shelters.Name, COUNT(Adoption.PetID) AS TotalAdoptedPets
FROM Shelters
JOIN Pets ON Shelters.ShelterID = Pets.PetID
JOIN Adoption ON Pets.PetID = Adoption.PetID
GROUP BY Shelters.Name
ORDER BY TotalAdoptedPets DESC;
