/*
--
-- This SQL script implements sample queries on the Monopoly database.
--
-- @author kvlinden
-- @version Summer, 2015
--

-- Get the number of Game records.
SELECT *
  FROM Game
  ;

-- Get the player records.
SELECT * 
  FROM Player
  ;

-- Get all the users with Calvin email addresses.
SELECT *
  FROM Player
 WHERE email LIKE '%calvin%'
 ;

-- Get the highest score ever recorded.
  SELECT score
    FROM PlayerGame
ORDER BY score DESC
   LIMIT 1
   ;

-- Get the cross-product of all the tables.
SELECT *
  FROM Player, PlayerGame, Game
  ;
*/

-- ============================================================
-- Lab 8.1 SQL Command File
-- @author: Moses Kuria
-- @version Fall 2025

-- ============================================================
-- Exercise 8.1.a
-- "Retrieve a list of all the games, ordered by date with the
--  most recent game coming first."
-- ============================================================
SELECT ID,
       time,
       status
FROM Game
ORDER BY time DESC;


-- ============================================================
-- Exercise 8.1.B
-- "Retrieve all the games that occurred in the past week."
-- ============================================================
SELECT ID,
       time,
       status
FROM Game
WHERE time >= NOW() - INTERVAL '7 days'
ORDER BY time DESC;


-- ============================================================
-- Exercise 8.1.c
-- "Retrieve a list of players who have (non-NULL) names."
-- ============================================================
SELECT ID,
       name,
       emailAddress
FROM Player
WHERE name IS NOT NULL
ORDER BY name;


-- ============================================================
-- Exercise 8.1.d
-- "Retrieve a list of IDs for players who have some game score
--  larger than 2000."
-- ============================================================
SELECT DISTINCT playerID
FROM PlayerGame
WHERE score > 2000
ORDER BY playerID;


-- ============================================================
-- Exercise 8.1.e
-- "Retrieve a list of players who have GMail accounts."
-- ============================================================
SELECT ID,
       name,
       emailAddress
FROM Player
WHERE emailAddress ILIKE '%@gmail.com'
ORDER BY ID;

-- ============================================================
-- Lab 8.2 PostgreSQL Queries and answers
-- @author: Moses Kuria
-- @version Fall 2025
-- ============================================================
-- Exercise 8.2.a
-- "Retrieve all 'The King''s game scores in decreasing order."
-- ============================================================
SELECT pg.gameID,
       pg.score
FROM Player AS p
JOIN PlayerGame AS pg
     ON p.ID = pg.playerID
WHERE p.name = 'The King'
ORDER BY pg.score DESC;


-- ============================================================
-- Exercise 8.2.b
-- "Retrieve the name of the winner of the game played on
--  2006-06-28 13:20:00."
-- ============================================================
SELECT p.name AS winner_name
FROM Game AS g
JOIN PlayerGame AS pg
     ON g.ID = pg.gameID
JOIN Player AS p
     ON pg.playerID = p.ID
WHERE g.time = '2006-06-28 13:20:00'
ORDER BY pg.score DESC
LIMIT 1;


-- ============================================================
-- Exercise 8.2.c
-- "So what does that P1.ID < P2.ID clause do in the last example
--  query (i.e., from SQL Examples)?"
-- ============================================================
--
-- It removes duplicates by keeping one ordering of each pair eg 
-- it keeps one of (Moses, John) and (John, Moses). It also 
-- prevents a player from being paired with themselves
--
-- ============================================================


-- ============================================================
-- Exercise 8.2.d
-- "The query that joined the Player table to itself seems
--  rather contrived. Can you think of a realistic situation in
--  which you’d want to join a table to itself?"
-- ============================================================
--
-- When comparing two different players' scores in the same game
-- 
-- ============================================================

