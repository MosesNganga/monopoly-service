--
-- This SQL script builds an extended Monopoly database, deleting any pre-existing version.
-- It supports games in progress by tracking cash, properties, houses, hotels, and positions.
--
-- @author Moses Kuria
-- @version Fall 2025
--

-- Drop previous versions of the tables if they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS Ownership;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- ================================================================
-- Create the schema
-- ================================================================

-- Game: represents each game session and whether it’s finished or ongoing
CREATE TABLE Game (
    ID integer PRIMARY KEY,
    time timestamp,
    status varchar(20) DEFAULT 'in progress' -- 'in progress' or 'finished'
);

-- Player: stores information about the players
CREATE TABLE Player (
    ID integer PRIMARY KEY,
    emailAddress varchar(50) NOT NULL,
    name varchar(50)
);

-- PlayerGame: links players to games and tracks their current cash, score, and position
CREATE TABLE PlayerGame (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    score integer,
    cash integer DEFAULT 1500,
    position integer DEFAULT 0, -- board square number (0–39)
    PRIMARY KEY (gameID, playerID)
);

-- Property: defines each property on the board
CREATE TABLE Property (
    ID integer PRIMARY KEY,
    name varchar(50) NOT NULL,
    cost integer NOT NULL,
    rent integer NOT NULL,
    color varchar(20),
    houseCost integer,
    hotelCost integer
);

-- Ownership: tracks which player owns which property in a given game
CREATE TABLE Ownership (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    propertyID integer REFERENCES Property(ID),
    houses integer DEFAULT 0,
    hotels integer DEFAULT 0,
    PRIMARY KEY (gameID, playerID, propertyID)
);

-- ================================================================
-- Allow users to select data from the tables
-- ================================================================
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON Ownership TO PUBLIC;

-- ================================================================
-- Add sample records
-- ================================================================

-- Games
INSERT INTO Game VALUES (10, '2025-10-20 09:30:00', 'in progress');
INSERT INTO Game VALUES (11, '2025-10-27 15:45:00', 'finished');

-- Players
INSERT INTO Player(ID, emailAddress, name) VALUES (5, 'mo.k@calvin.edu', 'Moses');
INSERT INTO Player VALUES (6, 'queenbee@gmail.com', 'Queen Bee');
INSERT INTO Player VALUES (7, 'puppy@gmail.com', 'Mr. Pup');

-- Player participation
INSERT INTO PlayerGame VALUES (10, 5, 1300, 1500, 3);
INSERT INTO PlayerGame VALUES (10, 6, 1100, 1450, 8);
INSERT INTO PlayerGame VALUES (11, 7, 4800, 1900, 0);

-- Property definitions
INSERT INTO Property VALUES (21, 'Electric Company', 150, 10, 'Utility', 0, 0);
INSERT INTO Property VALUES (22, 'Reading Railroad', 200, 25, 'Railroad', 0, 0);
INSERT INTO Property VALUES (23, 'Vermont Avenue', 100, 6, 'Light Blue', 50, 50);

-- Ownership status
INSERT INTO Ownership VALUES (10, 5, 21, 0, 0);  -- Moses owns Electric Company
INSERT INTO Ownership VALUES (10, 6, 22, 0, 0);  -- Queen Bee owns Reading Railroad
INSERT INTO Ownership VALUES (11, 7, 23, 1, 0);  -- Mr. Pup owns Vermont Ave with 1 house
