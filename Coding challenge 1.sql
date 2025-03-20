CREATE DATABASE PetPals;
USE PetPals;

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

SELECT Name, Age, Breed, Type FROM Pets WHERE AvailableForAdoption = 1;

SELECT ParticipantName, ParticipantType 
FROM Participants
WHERE EventID = ?;

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
