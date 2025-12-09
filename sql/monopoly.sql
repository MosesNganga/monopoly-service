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
INSERT INTO Game (ID, time, status) VALUES
  (1, '2025-01-01 14:00:00', 'in progress'),
  (2, '2025-01-02 18:30:00', 'in progress'),
  (3, '2025-01-05 20:15:00', 'finished');

-- Players
INSERT INTO Player (ID, emailAddress, name) VALUES
  (1, 'moses@example.com',     'Moses'),
  (2, 'queenbee@example.com',  'Queen Bee'),
  (3, 'pup@example.com',       'Mr. Pup'),
  (4, 'test@example.com',      'Test Player');

-- Properties
INSERT INTO Property (ID, name, cost, rent, color, houseCost, hotelCost) VALUES
  (1, 'Mediterranean Avenue', 60,  2, 'Brown',      50,  50),
  (2, 'Baltic Avenue',        60,  4, 'Brown',      50,  50),
  (3, 'Reading Railroad',    200, 25, 'Railroad',    0,   0),
  (4, 'Oriental Avenue',     100,  6, 'Light Blue', 50,  50),
  (5, 'Vermont Avenue',      100,  6, 'Light Blue', 50,  50),
  (6, 'Electric Company',    150, 10, 'Utility',     0,   0);

-- Player participation (PlayerGame)
INSERT INTO PlayerGame (gameID, playerID, score, cash, position) VALUES
  -- Game 1
  (1, 1,  0, 1500, 1),
  (1, 2,  0, 1500, 2),

  -- Game 2
  (2, 1, 10, 1400, 5),
  (2, 3, 20, 1600, 8),
  (2, 4, 15, 1500, 3),

  -- Game 3
  (3, 2, 35, 2000, 10),
  (3, 3, 25, 1800, 7);

-- Ownership status
INSERT INTO Ownership (gameID, playerID, propertyID, houses, hotels) VALUES
  -- Game 1
  (1, 1, 1, 0, 0),
  (1, 2, 2, 0, 0),

  -- Game 2
  (2, 3, 3, 0, 0),
  (2, 4, 4, 1, 0),
  (2, 1, 6, 0, 0),

  -- Game 3
  (3, 2, 5, 2, 0),
  (3, 3, 1, 0, 0);
