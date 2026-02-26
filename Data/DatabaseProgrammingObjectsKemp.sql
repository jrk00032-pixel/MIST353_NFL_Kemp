-- 3 queries
-- 1 each for ConferenceDivision and Team tables, and 1 join query


-- ConferenceDivision Querie


SELECT 
    ConferenceDivisionID,
    Conference,
    Division
FROM dbo.ConferenceDivision
ORDER BY Conference, Division;


-- TEAM Querie 


SELECT 
    TeamID,
    TeamName,
    TeamCityState,
    TeamColors,
    ConferenceDivisionID

FROM dbo.Team
ORDER BY TeamName;


-- INNER JOIN Querie


SELECT 
    t.TeamName,
    t.TeamCityState,
    t.TeamColors,
    cd.Conference,
    cd.Division
FROM dbo.Team t
INNER JOIN dbo.ConferenceDivision cd
    ON t.ConferenceDivisionID = cd.ConferenceDivisionID
ORDER BY cd.Conference, cd.Division, t.TeamName;



-- INNER JOIN Querie with WHERE clause to filter for AFC East teams From Class Discussion

declare @myTeamName nvarchar(50) = 'Buffalo Bills';

SELECT TeamName, TeamColors, Conference, Division
FROM dbo.Team t
INNER JOIN dbo.ConferenceDivision cd
    ON t.ConferenceDivisionID = cd.ConferenceDivisionID
    WHERE cd.Conference = 'AFC' AND cd.Division = 'East'
ORDER BY t.TeamName;


/*
create or alter procedure procGetTeamsByConferenceDivision
    @Conference NVARCHAR(50) = null,
    @Division NVARCHAR(50) = null

*/

